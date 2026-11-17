import logging
import requests, zipfile, sys, json, os, glob, re, shutil, time, fnmatch
from dotenv import load_dotenv

logging.basicConfig(level=logging.INFO, format='%(asctime)s [%(levelname)s]: %(message)s', datefmt='%Y-%m-%d %H:%M:%S')
LOGGER = logging.getLogger(__name__)
# Load the .env file
load_dotenv()

# Access the variables
baseSaveLocation = os.getenv("BASE_SAVE_LOCATION")

LOGGER.info("Base Save Location: %s", baseSaveLocation)

from pathlib import Path
from datetime import datetime, timezone, timedelta
import argparse
import urllib.parse
from pprint import pprint

# Parse command-line arguments
parser = argparse.ArgumentParser(description="GitHub Artifact Processor")
parser.add_argument('--github-token', type=str, required=True, help="GitHub token for authentication")
parser.add_argument('--workflow', type=str, required=True, help="Workflow file name")
parser.add_argument('--rt', type=str, required=False, help="Current Runtime Version")
parser.add_argument('--run-id', type=str, required=False,
                    help="The workflow run to report on (github.run_id). Without it, the newest run of the workflow is used, "
                         "which can be another run that happens to be in progress at the same time")
parser.add_argument('--pr', type=int, required=False,
                    help="Pull request number: report this run's failures without filing bug reports, and fail on any "
                         "test the pull request adds or changes that fails")
parser.add_argument('--head-sha', type=str, required=False,
                    help="The pull request's head commit, where its tests' code is read from (required with --pr)")
args = parser.parse_args()
if args.pr and not args.head_sha:
    parser.error("--head-sha is required with --pr: the pull request's tests are read from its head commit")

# Get GitHub token from arguments
github_token = args.github_token
workflow = args.workflow
RTVersion = args.rt
RunID = args.run_id
PRNumber = args.pr
HeadSHA = args.head_sha
# set when a pull request run finds a failing test it adds or changes; the script then exits 1
pr_touched_fails = []
# why a pull request run couldn't work out which tests it adds or changes; the script then exits 1
pr_tests_incomplete = []
# set once compare_artifacts has read this run's results
compared = False

# Set to True to bypass the workflow/branch allow-list (for testing)
FILTER_RUNS = False

saveLocation = ['new_data', 'prev_data']

repos = ['YoYoGames/GameMaker-Bugs', 'YoYoGames/GM-TestFramework', 'YoYoGames/TF_Bug_Report_Holding']
issue_message_days = 7
artifact_data_store = {"artifact_web_download_url": ""}
testRunTimes = {
    "VM" : "",
    "YYC" : ""
}

# declare variables
_artifactRunID = []
_artifactID = []
_download_artifacts_url = {}
artifact_files = []
slack_stats = {}

run_start_time = 0
run_time_taken = 0
total_new_reports = 0
total_reopened_reports = 0
total_existing_reports = 0

# Create new_data and prev_data directories if they don't exists
for dir in saveLocation:
    directory = Path(f"{baseSaveLocation}/{dir}")
    directory.mkdir(parents=True, exist_ok=True)

def auth_headers():
    headers = {}
    if github_token:
        headers['Authorization'] = f'Bearer {github_token}'
        headers['Accept'] = 'application/vnd.github.v3+json'
    return headers


# A test is declared as addFact("name", ...), addTestAsync("name", ...) or addTheory("name", ...)
TEST_DECLARATION = re.compile(r'\badd(?:Fact|TestAsync|Theory)\(\s*"([^"]+)"')


def changed_lines(patch):
    """The line numbers (in the new file) that a unified diff patch adds, or next to which it removes lines."""
    changed = set()
    new_line = 0
    for line in patch.split("\n"):
        hunk = re.match(r'^@@ -\d+(?:,\d+)? \+(\d+)(?:,\d+)? @@', line)
        if hunk:
            new_line = int(hunk.group(1))
        elif line.startswith("+"):
            changed.add(new_line)
            new_line += 1
        elif line.startswith("-"):
            # a removal changes the test it was in: count the line that now follows it
            changed.add(new_line)
        elif not line.startswith("\\"):
            new_line += 1
    return changed


def declared_tests(lines):
    """Each test declared in a file, with the 1-based first and last line of its block.

    A block runs to the line before the next declaration (or the end of the file). Counting braces doesn't work:
    a multi-line addTheory's first data row closes its braces, and strings can hold braces. This can only take in
    more lines than the test's own, never fewer.
    """
    starts = [(i + 1, m.group(1)) for i, line in enumerate(lines) if (m := TEST_DECLARATION.search(line))]
    return [(name, first, starts[n + 1][0] - 1 if n + 1 < len(starts) else len(lines))
            for n, (first, name) in enumerate(starts)]


def get_pr_tests():
    """The names of the tests the pull request adds or changes: those whose block has a line it adds or removes.

    Anything that stops this from being worked out is added to pr_tests_incomplete, so the run fails rather than
    passing without checking the pull request's tests.
    """
    tests = set()
    page = 1
    while True:
        response = requests.get(f"https://api.github.com/repos/{repos[1]}/pulls/{PRNumber}/files?per_page=100&page={page}",
                                headers=auth_headers())
        if response.status_code != 200:
            pr_tests_incomplete.append(f"Failed to read the files of pull request #{PRNumber}. HTTP Status: {response.status_code}")
            return tests
        files = response.json()
        for changed in files:
            path = changed.get("filename", "")
            if not path.endswith(".gml") or changed.get("status") == "removed":
                continue
            source = get_file(path, HeadSHA)
            if source is None:
                pr_tests_incomplete.append(f"Failed to read {path} at {HeadSHA}")
                continue
            blocks = declared_tests(source.split("\n"))
            if changed.get("patch"):
                lines = changed_lines(changed["patch"])
                tests.update(name for name, first, last in blocks if any(first <= n <= last for n in lines))
            else:
                # GitHub leaves the patch out of large diffs: count every test in the file as changed
                LOGGER.warning(f"No diff for {path} (too large): counting all its tests as changed")
                tests.update(name for name, first, last in blocks)
        if len(files) < 100:
            break
        page += 1
    LOGGER.info(f"Tests pull request #{PRNumber} adds or changes: {sorted(tests)}")
    return tests


def get_file(path, ref):
    """A file's text at a commit, or None."""
    response = requests.get(f"https://api.github.com/repos/{repos[1]}/contents/{urllib.parse.quote(path)}?ref={ref}",
                            headers={**auth_headers(), 'Accept': 'application/vnd.github.raw'})
    if response.status_code != 200:
        LOGGER.warning(f"Failed to read {path} at {ref}. HTTP Status: {response.status_code}")
        return None
    return response.text


def is_pr_test(testName, pr_tests):
    # a theory's results may add its arguments to the declared name
    return any(testName == name or testName.startswith(name + " ") for name in pr_tests)


# FUNCTION LIST:
# 1. get_workflow_runs
# 2. get_artifact_URL
# 3. download_github_artifact
# 4. unzip_artifact_files
# 5. compare_artifacts
# 6. get_issues
# 7. log_fail
# 8. get_code
                                    
# Get the workflow run for a given runtime version (or the latest), plus the previous one
def get_workflow_runs():

    global run_start_time

    headers = {}
    if github_token:
        headers['Authorization'] = f'Bearer {github_token}'
        headers['Accept'] = 'application/vnd.github.v3+json'

    # pull more than 2 so we can locate an older runtime version when testing
    response = requests.get(f"https://api.github.com/repos/{repos[1]}/actions/workflows/{workflow}/runs?per_page=30", headers=headers, stream=True)

    if response.status_code != 200:
        LOGGER.error(f"Failed to get workflow runs. HTTP Status: {response.status_code}")
        return

    workflow_runs = response.json().get("workflow_runs", [])

    allowed_workflows = {'Beta', 'Monthly', 'Red', 'LTS2026'}
    allowed_branches = {'develop', '2026.0.0-main'}

    # only the runs we care about, newest first (GitHub returns them newest first)
    if FILTER_RUNS:
        valid_runs = [
            run for run in workflow_runs
            if run['head_branch'] in allowed_branches and run['name'] in allowed_workflows
        ]
    else:
        valid_runs = workflow_runs

    if not valid_runs:
        LOGGER.error("Valid workflow not used, only Beta, Monthly, Red or LTS2026 on the develop / 2026.0.0-main branch is accepted for the TF Compare script")
        return

    # Decide which run is the "current" one
    if RunID:
        # the run that called the script - never another run that happens to be newer
        response = requests.get(f"https://api.github.com/repos/{repos[1]}/actions/runs/{RunID}", headers=headers)
        if response.status_code != 200:
            LOGGER.error(f"Failed to get workflow run {RunID}. HTTP Status: {response.status_code}")
            sys.exit(1)
        current_run = response.json()
        _artifactRunID.append(current_run['id'])
        if not PRNumber:
            # the previous valid run is the newest one older than this
            older = [run for run in valid_runs if run['id'] != current_run['id']
                     and run['created_at'] < current_run['created_at']]
            if older:
                _artifactRunID.append(older[0]['id'])
        # a pull request run isn't compared with another run: CI.yml only runs on pull requests, so the
        # "previous" run would be some other pull request's
        run_start_time = datetime.strptime(current_run['run_started_at'], '%Y-%m-%dT%H:%M:%SZ').replace(tzinfo=timezone.utc)
        get_artifact_URL()
        return

    if RTVersion:
        # find the run whose summary_file artifact matches the requested runtime version
        target_index = next(
            (i for i, run in enumerate(valid_runs)
             if run_has_summary_for_rt(run['id'], RTVersion, headers)),
            None
        )
        if target_index is None:
            LOGGER.error(f"No workflow run found with a summary_file artifact for runtime version '{RTVersion}'")
            # log what the newest run actually has so the mismatch is visible in the workflow log
            newest_names = get_artifact_names(valid_runs[0]['id'], headers)
            LOGGER.error(f"Artifacts on newest run {valid_runs[0]['id']}: {newest_names}")
            return
    else:
        # no runtime version supplied -> behave as before (latest run)
        target_index = 0

    current_run = valid_runs[target_index]
    _artifactRunID.append(current_run['id'])

    # the previous valid run (next one down the list), if there is one
    if target_index + 1 < len(valid_runs):
        _artifactRunID.append(valid_runs[target_index + 1]['id'])

    # set the run start time from the current run
    run_start_time = datetime.strptime(current_run['run_started_at'], '%Y-%m-%dT%H:%M:%SZ')
    run_start_time = run_start_time.replace(tzinfo=timezone.utc)  # make it timezone-aware

    get_artifact_URL()


# Return the list of artifact names for a run (empty list on error)
def get_artifact_names(run_id, headers):
    response = requests.get(f"https://api.github.com/repos/{repos[1]}/actions/runs/{run_id}/artifacts?per_page=100", headers=headers)
    if response.status_code != 200:
        LOGGER.warning(f"Could not read artifacts for run {run_id}. HTTP Status: {response.status_code}")
        return []
    return [a.get("name", "") for a in response.json().get("artifacts", [])]


# True if the given run uploaded a summary_file artifact for this runtime version.
# Match tolerantly: the artifact is named "summary_file-<RUNTIME_VERSION>" but we don't
# rely on an exact string equality (which breaks on any stray whitespace or format drift).
def run_has_summary_for_rt(run_id, rt_version, headers):
    rt = str(rt_version).strip()
    for name in get_artifact_names(run_id, headers):
        if "summary_file" in name and rt in name:
            return True
    return False



def get_artifact_URL():

    global artifact_data_store

    for runindex, runid in enumerate(_artifactRunID, start=1):
        # track which TF run we are getting artifact details for ('Current' or 'Previous')
        runState = "Current" if runindex == 1 else "Previous"

        artifact_url = f"https://api.github.com/repos/{repos[1]}/actions/runs/{runid}/artifacts"

        response = requests.get(artifact_url, headers=auth_headers())

        if response.status_code == 200:
            # Parse the JSON response
            artifact_data = response.json()

            artifact_details = artifact_data.get("artifacts", [])

            # Find the summary_file artifact by name (order is not guaranteed for older runs).
            # The summary_file needs to exist for the script to continue.
            for artifact in artifact_details:
                if "summary_file" in artifact.get("name", ""):
                    # add the run's summary artifact id to the array
                    _artifactID.append(artifact['id'])
                    _download_artifacts_url[runState] = artifact.get("archive_download_url")
                    break
        else:
            LOGGER.error(f"Failed to artifact URL. HTTP Status: {response.status_code}")

    # Time to download the artifact files, ensure the current run has a valid artifact file
    if (len(_download_artifacts_url) > 0) and _download_artifacts_url.get('Current'):
        download_github_artifact(_download_artifacts_url)
    else:
        LOGGER.error(f"No artifact files available in the current workflow run!\nTF Compare script will not continue")
        if RunID:
            # this run's own results are missing, so nothing was checked: that mustn't pass
            sys.exit(1)


def download_github_artifact(_download_artifacts_url):

    # iterate through the _download_artifacts_url array and download each artifact file
    urlCount = 0
    LOGGER.info("Downloading artifact files")
    
    for url in _download_artifacts_url:

        save_path = f"{baseSaveLocation}/{saveLocation[urlCount]}/"

        headers = {}
        if github_token:
            headers['Authorization'] = f'Bearer {github_token}'
            headers['Accept'] = 'application/vnd.github.v3+json'

        response = requests.get(_download_artifacts_url.get(url), headers=headers, stream=True)
        
        if response.status_code == 200:
            with open(f"{save_path}artifact.zip", 'wb') as file:
                for chunk in response.iter_content(chunk_size=8192):
                    file.write(chunk)

            # unzip the VM and YYC json files
            artifact_files = unzip_artifact_files(save_path, "artifact.zip")

            urlCount +=1
        else:
            LOGGER.error(f"Failed to download artifact. HTTP Status: {response.status_code}")

    # time to compare the artifact files
    if len(artifact_files) >= 1:
        LOGGER.info("Artifacts successfully downloaded")
        compare_artifacts(artifact_files)



def unzip_artifact_files(save_path, zipfilename):#
    # Path to the zip file
    zip_file = save_path + zipfilename
    # Path to extract the specific file to
    extract_to = save_path

    # Extract the ZIP file
    with zipfile.ZipFile(zip_file, 'r') as zip_ref:

        # Get list of filenames in zipfile
        zip_files = zip_ref.namelist()

        # List only JSON files without "sandbox" in their names
        artifact_files = [f for f in zip_files if f.endswith(".json") and "sandbox" not in f.lower()]

        #check if artifact files exists
        if len(artifact_files)> 0:
            for art_file in artifact_files:
                # Extract each josn file
                zip_ref.extract(art_file, extract_to)
        else:
            LOGGER.warning("No files found in the artifact archive.")

    return artifact_files



def compare_artifacts(artifact_files):

    global total_new_reports
    global total_reopened_reports
    global total_existing_reports
    global artifact_data_store
    global run_start_time
    global run_time_taken

    global compared

    allTestFiles = {}
    fileCount = 1

    LOGGER.info("Processing and Comparing artifact data")
    
    # for each data directory
    for data in saveLocation:
        # for each json file
        for art_file in artifact_files:
            
            # json file location
            file_path = Path(f"{baseSaveLocation}/{data}/{art_file}")
            # check the file exists
            if file_path.exists():
                # open and read the json file
                with open(file_path, 'r') as file:

                    #if fileCount == 0:
                    # eg. xUnit_windows_VM_1, xUnit_windows_YYC_1 - Latest Test Run
                    #     xUnit_windows_VM_2, xUnit_windows_YYC_2 - Previous Test Run
                    allTestFiles[f"{art_file}_{fileCount}"] = json.load(file)
            else:
                LOGGER.warning(f"File in {file_path} does not exist.")
        fileCount +=1

    compared = any(key.endswith("_1") for key in allTestFiles)

    if len(allTestFiles) > 0:
        # define variable to hold failed data
        testFails = {}
        new_skips = {}
        for index, tfData in enumerate(allTestFiles, start=1):

            # get VM and YYC test run times
            if (index == 1):
                testRunTimes['VM'] = allTestFiles[tfData]['time']
            elif (index == 2):
                testRunTimes['YYC'] = allTestFiles[tfData]['time']

            for testsuite in allTestFiles[tfData]["testsuites"]:
                # check if testsuite contains any fails
                if testsuite["tallies"]["failures"] > 0 or testsuite["tallies"]['skipped'] > 0:
                    testSuiteName = testsuite["name"]
                    # iterate through the tests
                    for test in testsuite["tests"]:
                        testResult = test["result"]
                        testName = test["name"]
                        testTime = test['time']

                        failsIndex = f"f{index}"

                        if failsIndex not in testFails:
                            testFails[failsIndex] = {}

                        # an async test that times out is "Expired": it failed too
                        if testResult.lower() in ("failed", "expired"):

                            if testResult.lower() == "expired" and not test['errors'] and not test['exceptions']:
                                testFails[failsIndex].setdefault(testName, {
                                    "testname": testName,
                                    "testSuite": testSuiteName,
                                    "errorDetails": {"message": "Test execution expired", "longMessage": "", "script": ""},
                                    "testTime" : testTime,
                                    "errorType" : "exception"
                                })
                            for errorDetails in test['errors']:
                                testFails[failsIndex].setdefault(testName, {
                                    "testname": testName,
                                    "testSuite": testSuiteName,
                                    "errorDetails": errorDetails,
                                    "testTime" : testTime,
                                    "errorType" : "error"
                                })
                            for exceptionDetails in test['exceptions']:
                                testFails[failsIndex].setdefault(testName, {
                                    "testname": testName,
                                    "testSuite": testSuiteName,
                                    "errorDetails": exceptionDetails,
                                    "testTime" : testTime,
                                    "errorType" : "exception"
                                })
                        elif testResult.lower() == "skipped" and index in range(1,3):
                            new_skips.setdefault(testName, testSuiteName)

        
    # compare VM to YYC and add in any missing
    ALLFails = []
    f1_Fails = []
    f2_Fails = []
    prev_fails_map = {}

    # the current run's files (VM, YYC): the previous run's may be missing
    newFilesToCompare = sum(1 for key in allTestFiles if key.endswith("_1"))
    testFails.setdefault("f1", {})
    testFails.setdefault("f2", {})

    # Only compare fails if there are more than 1 file to compare
    if newFilesToCompare > 1:
        for f1Fails in testFails["f1"]:
            # Store fails that appear in both Vm and YYC
            if f1Fails in testFails["f2"]:
                ALLFails.append(testFails["f1"][f1Fails])
            # Store only fails that appear in VM
            elif f1Fails not in testFails["f2"]:
                f1_Fails.append(testFails["f1"][f1Fails])

        for f2Fails in testFails["f2"]:
            # store fails that only appear in YYC
            if f2Fails not in testFails["f1"]:
                f2_Fails.append(testFails["f2"][f2Fails])
    else:
        # store fails that only appear in YYC
        for f1Fails in testFails["f1"]:
            ALLFails.append(testFails["f1"][f1Fails])

    for testRun in testFails:
        # if the last character of the of 'testRun' is not 1 then start processing
        if int(testRun[-1]) > newFilesToCompare:
            for prevTestFail in testFails[testRun]:
                prev_fails_map.setdefault(prevTestFail, testFails[testRun][prevTestFail])

    # Calculate the time difference
    timestamp = datetime.now(timezone.utc)
    calc_time_taken = timestamp - run_start_time
    total_run_time = timedelta(seconds=calc_time_taken.seconds)


    # Ouput fails
    with open("TF_Output.txt", "w") as file:

        failsWrapper = [ALLFails, f1_Fails, f2_Fails]
        totalFails = (len(ALLFails) + len(f1_Fails) + len(f2_Fails))

        file.write("\n****************************************************************************************\n")
        file.write("******************************* TEST FRAMEWORK FAILURES ********************************\n")
        file.write("****************************************************************************************\n")

        # get first fails dict
        first_fail_dict = allTestFiles[next(iter(allTestFiles))]

        file.write(f"\nWorkflow: {workflow}\n")
        file.write(f"Runtime Version: {RTVersion}\n")

        # Convert artifact timestamp to readable format
        dt_object = datetime.strptime(first_fail_dict["timestamp_iso"], "%Y-%m-%dT%H:%M:%S")
        # Format it in a readable way
        file.write(f"\nArtifact Date/Time: {dt_object.strftime("%d %B, %Y at %I:%M %p")}\n")
        file.write(f"\nTotal Run Time: {total_run_time}\n")
        # total number of testsuites and fail stats
        file.write(f"Total Testsuites: {len(first_fail_dict["testsuites"])}\n")
        file.write(f"Total Tests: {first_fail_dict['tallies']["tests"]}\n")
        file.write(f"Total Assertions: {first_fail_dict['tallies']["assertions"]}\n")
        file.write(f"Total Failed Tests: ({totalFails}) = ({round((totalFails / first_fail_dict['tallies']["tests"]) * 100, 2)})%\n")
        file.write(f"Total Skipped Tests: ({first_fail_dict['tallies']["skipped"]}) = ({round((first_fail_dict['tallies']["skipped"] / first_fail_dict['tallies']["tests"]) * 100, 2)})%\n")

        # the tests a pull request adds or changes
        pr_tests = get_pr_tests() if PRNumber else set()

        # iterate through each test suite
        new_fails_map = {}
        compiler = ["VM and YYC", "VM", "YYC"]
        testCounter = 1

        for cIndex, fArray in enumerate(failsWrapper, start=0):

            if len(fArray) > 0:

                file.write(f"\n********************************** {compiler[cIndex]} Fails ***********************************\n")

                # total number of failures in current test run
                file.write(f"\nTotal Failures: {len(fArray)}\n")
            
                for failTest in fArray:

                    if PRNumber:
                        # a pull request run files no reports: its tests may be waiting for a runtime fix
                        bug_report_url = "not filed (pull request run)"
                        if is_pr_test(failTest["testname"], pr_tests):
                            pr_touched_fails.append(f"[{compiler[cIndex]}] {failTest['testname']} in {failTest['testSuite']}")
                    else:
                        # get code
                        test_code_details = get_code(failTest["testname"], failTest["testSuite"])

                        # log fail as an issue on GitHub - return report URL
                        bug_report_url = log_fail(failTest["testname"], failTest, compiler[cIndex], test_code_details)

                    file.write("\n----------------------------------------------------------------------------------------\n")
                    
                    file.write(f"\nFail No: {testCounter}\n")
                    file.write(f"Bug Report URL: {bug_report_url}\n")
                    file.write(f"Testsuite Name: {failTest["testSuite"]}\n")

                    if failTest['errorType'] == 'error':
                        file.write(f"Test Name: {failTest["testname"]}\n")
                        if "description" in failTest['errorDetails']:
                            file.write(f"\nBug Title: TestFrameWork: {failTest["testname"]} in {failTest["testSuite"]}, {failTest['errorDetails']['description']}\n")
                            # get details for all errors on each test
                            new_fails_map.setdefault(failTest["testname"], f"{failTest["testSuite"]}, {failTest['errorDetails']['description']}")
                            file.write(f"Title: {failTest['errorDetails']['title']}\n")
                            file.write(f"Description: {failTest['errorDetails']['description']}\n")
                            file.write(f"Expected value: {failTest['errorDetails']['expected']}\n")
                            file.write(f"Actual value: {failTest['errorDetails']['actual']}\n")
                            file.write(f"Stack: {failTest['errorDetails']['stack']}\n")
                        else:
                            new_fails_map.setdefault(failTest["testname"], f"{failTest["testSuite"]}, {failTest['errorDetails']['message']}")
                            file.write(f"Description: {failTest['errorDetails']['message']}\n")
                    elif failTest['errorType'] == 'exception':
                        file.write(f"\nBug Title: TestFrameWork: {failTest["testname"]} in {failTest["testSuite"]}, {failTest['errorDetails']['message']}\n")
                        new_fails_map.setdefault(failTest["testname"], f"{failTest["testSuite"]}, {failTest['errorDetails']['message']}")
                        file.write(f"Test Name: {failTest["testname"]}\n")
                        file.write(f"Message: {failTest['errorDetails']['message']}\n")
                        file.write(f"Long Message: {failTest['errorDetails']['longMessage']}\n")
                        file.write(f"Script: {failTest['errorDetails']['script']}\n")

                    # increment test number by 1
                    testCounter +=1

            elif len(failsWrapper[0]) + len(failsWrapper[1]) + len(failsWrapper[2]) == 0:
                LOGGER.info(f"No fails have been identified in this run for {compiler[cIndex]}.")
                

        file.write("\n************************************** NEW FAILS ***************************************\n")

        failcount = 0
        for new_error in new_fails_map:
            if new_error not in prev_fails_map:
                file.write(f"\n{new_error} - {new_fails_map[new_error]}\n")
                failcount +=1
        
        if failcount == 0:
            file.write("\nNo new fails have been identified\n")

        file.write("\n**************************** RECENT FIXES TO MARK VERIFIED *****************************\n")

        fixcount = 0
        for prev_error in prev_fails_map:
            if prev_error not in new_fails_map:
                file.write(f"\n{prev_error} - {prev_fails_map[prev_error]}\n")
                fixcount +=1

        if fixcount == 0:
            file.write("\nNo fixes to verify\n")

        file.write("\n************************************ SKIPPED TESTS ************************************\n")

        for skipped in new_skips:
            file.write(f"\n{skipped} : in {new_skips[skipped]}\n")

        file.write("\n****************************************************************************************\n")
        file.write("*********************************** END OF FILTERING ***********************************\n")
        file.write("****************************************************************************************\n")

        # confirm successful creation of output file
        LOGGER.info("TEXT file 'TF_Output.txt' was created successfully!")


    # Remove all downloaded artifacts files
    for art_dir in saveLocation:
        directory = f"{baseSaveLocation}/{art_dir}"

        # Get all files in the directory
        files = glob.glob(os.path.join(directory, "*"))  

        for file in files:
            if os.path.isfile(file):  # Ensure it's a file (not a folder)
                os.remove(file)

    LOGGER.info("Artifact comparison has completed")
    LOGGER.info("All downloaded artifact files deleted.")

    # _artifactRunID
    # _artifactID

    artifact_url = f"https://api.github.com/repos/{repos[1]}/actions/runs/{_artifactRunID[0]}/artifacts"
    response = requests.get(artifact_url)
    if response.status_code == 200:
        # Parse the JSON response
        artifact_data = response.json()
        artifact_details = artifact_data.get("artifacts", [])
        for index, artifact in enumerate(artifact_details, start=1):          
            # only get tf_output file for current run if it already exists (re-run)
            if "tf_compare" in artifact.get("name"):
                artifact_data_store["artifact_web_download_url"] = f"<https://github.com/{repos[1]}/actions/runs/{_artifactRunID[0]}/artifacts/{artifact['id']}>"


    # build JSON file content for Slack Notification
    LOGGER.info("Creating Slack JSON Stats file")
    slack_stats["text"] = f"*{RTVersion} {workflow.split(".")[0]} Test Results Summary*"
    slack_stats["Runtime-Version"] = RTVersion
    slack_stats["attachments"] = [
        {
            "color": "#36a64f",
            "fields": [
                { "title": "Total Run Time", "value": f"{total_run_time}", "short": True },
                { "title": "Total tests", "value": str(first_fail_dict['tallies']["tests"]), "short": True },
                { 
                    "title": "Total failed tests", 
                    "value": f"{totalFails} ({round((totalFails / first_fail_dict['tallies']['tests']) * 100, 2)}%)", 
                    "short": True
                },
                { 
                    "title": "Total skipped tests", 
                    "value": f"{first_fail_dict['tallies']['skipped']} ({round((first_fail_dict['tallies']['skipped'] / first_fail_dict['tallies']['tests']) * 100, 2)}%)", 
                    "short": True
                },
                { "title": "Total Reports Created", "value": f"{total_new_reports}", "short": True },
                { "title": "Total Reports Reopened", "value": f"{total_reopened_reports}", "short": True },
                { "title": "Total Reports Unresolved (>= 7 Days)", "value": f"{total_existing_reports}", "short": True },
                { 
                    "title": "Output file", 
                    "value": f"{artifact_data_store['artifact_web_download_url']}", 
                    "short": False
                }
            ]
        }
    ]

    # write slack stats json file
    with open("slack_stats.json", "w") as slackfile:
        # Convert the list to a JSON-formatted string
        json.dump(slack_stats, slackfile, indent=4)
        LOGGER.info("JSON file 'slack_stats.json' was created successfully!")


#Get failed test code block and lines
def get_code(testname, testsuite):

    headers = {}
    if github_token:
        headers['Authorization'] = f'Bearer {github_token}'
        headers['Accept'] = 'application/vnd.github+json'

     # Define repo and file info
    BRANCH = HeadSHA or "develop"
    FILE_PATH = f"projects/xUnit/scripts/{testsuite}/{testsuite}.gml"

    # Construct raw file URL
    raw_url = f"https://raw.githubusercontent.com/{repos[1]}/{BRANCH}/{FILE_PATH}"

    # Fetch raw file contents
    response = requests.get(raw_url)

    if response.status_code == 200:
        lines = response.text.split("\n")

        function_block = []
        found = False
        brace_count = 0  # Track { } balance

        for i, line in enumerate(lines, start=1):
            if testname in line and not found:
                found = True
                function_block.append(line)
                start_line = i
                brace_count += line.count("{") - line.count("}")  # Track opening braces
                continue

            if found:
                function_block.append(line)
                brace_count += line.count("{") - line.count("}")  # Update balance

                if brace_count == 0:  # All braces closed → function ends
                    end_line = i
                    break

        if found:
            # Print extracted function block
            function_code = "\n".join(function_block)
            permalink = f"https://github.com/{repos[1]}/blob/{BRANCH}/{FILE_PATH}#L{start_line}-L{end_line}"
            
            return [function_code, permalink]
        else:
            LOGGER.warning(f"Function not found in file: {testname} in {FILE_PATH} at {BRANCH}")
    else:
        LOGGER.error(f"Failed to fetch file. HTTP Status: {response.status_code}")
    return ["(the test's code could not be found)", f"https://github.com/{repos[1]}/blob/{BRANCH}/{FILE_PATH}"]


# create new bug report / comment on existing report
def log_fail(testName, failDetails, compiler, test_code_details):

    global total_new_reports
    global total_reopened_reports
    global total_existing_reports

    # ENCODED_TERM = urllib.parse.quote(f"{compiler} {testName}", safe="")
    
    # search issues for exists reports
    headers = {}
    if github_token:
        headers['Authorization'] = f'Bearer {github_token}'
        headers['Accept'] = 'application/vnd.github.v3+json'

    # Search all repositories
    LOGGER.info(f"Searching for test: {testName}")
    issue_search = next((data for repo in repos if (data := get_issues(repo, testName, compiler))), None)


    if issue_search != None:
        LOGGER.info(f"Report has been found for: {testName} in Repo: {issue_search[1]}")
        # fail has already been written up
        # check its state (open/closed)
        for report in issue_search[0]['items']:
            if report['state'] == 'closed':
                # reopen report and add new comment with new fail info
                issue_data = {
                    "state": "open",
                }

                response = requests.patch(report['url'], headers=headers, json=issue_data)

                if response.status_code == 200:
                    LOGGER.info("This issue is currently marked as closed!")
                    LOGGER.info(f"Issue: {report['number']} - {testName}, successfully reopened")
                    LOGGER.info(f"Bug Report URL: {report['html_url']}")
                    # add 1 to the reopened count
                    total_reopened_reports += 1
                    # add new comment to bug report
                    if 'description' in failDetails['errorDetails']:
                        comment_data = {
                            "body": f"TestFramework reports this fails again in [{compiler}] Runtime Version: {RTVersion}\n\n" 
                                        f"Title: {failDetails['errorDetails']['title']}\n"
                                        f"Description: {failDetails['errorDetails']['description']}\n"
                                        f"Actual: {failDetails['errorDetails']['actual']}\n"
                                        f"Expected: {failDetails['errorDetails']['expected']}"
                        }
                    else:
                        comment_data = {
                            "body": f"TestFramework reports this fails again in [{compiler}] Runtime Version: {RTVersion}\n\n" 
                                        f"Message: {failDetails['errorDetails']['message']}\n"
                                        f"Long Message: {failDetails['errorDetails']['longMessage']}"
                        }

                    response = requests.post(report['comments_url'], headers=headers, json=comment_data)

                    if response.status_code == 201:
                        LOGGER.info(f"Issue: {report['number']} - {testName}, new comment successfully added to report")
                        break
                    else:
                        LOGGER.warning(f"Issue: {report['number']} - {testName}, adding a new comment was unsuccessful!")
                        break
                else:
                    LOGGER.warning(f"Issue: {report['number']} - {testName}, could not be reopened")

            #  the found report is still open and unresolved
            elif report['state'] == 'open':
                # comment on issue that the issue still occurs
                # only comment if last comment from the script was at least 7 days old
                # only get comments if the report is at least 7 days old
                report_date = datetime.strptime(report['created_at'], "%Y-%m-%dT%H:%M:%SZ").replace(tzinfo=timezone.utc)

                 # Get today's date using datetime.now() with UTC timezone
                today_date = datetime.now(timezone.utc)

                if report_date <= today_date - timedelta(days=issue_message_days):

                    response = requests.get(f"{report['comments_url']}?per_page=30", headers=headers)

                    if response.status_code == 200:
                        comments = response.json()
                        sorted_comments = sorted(comments, key=lambda c: c["created_at"], reverse=True)  # Sort by newest first
                        
                        # iterate through the comments newset to oldest
                        if len(comments) == 0:
                            if report_date <= today_date - timedelta(days=issue_message_days):
                                comment_data = {
                                            "body": f"TestFramework reports this still fails in [{compiler}] Runtime Version: {RTVersion}"
                                        }
                                # increment the tally by 1
                                total_existing_reports += 1
                        else:
                            for comment in sorted_comments:

                                # check if the comment text is a TF update
                                if "TestFramework reports" in comment['body']:
                                    # Convert the comment's created_at to a datetime object (UTC timezone)
                                    comment_date = datetime.strptime(comment['created_at'], "%Y-%m-%dT%H:%M:%SZ").replace(tzinfo=timezone.utc)

                                    # Compare the two dates - make new comment if last TF update was over 7 days ago
                                    if comment_date <= today_date - timedelta(days=issue_message_days):
                                        comment_data = {
                                            "body": f"TestFramework reports this still fails in [{compiler}] Runtime Version: {RTVersion}"
                                        }

                                        # increment the tally by 1
                                        total_existing_reports += 1

                                        response = requests.post(report['comments_url'], headers=headers, json=comment_data)

                                        if response.status_code == 201:
                                            LOGGER.info(f"Issue: {report['number']} - {testName}, new comment successfully added to report")
                                            break
                                        else:
                                            LOGGER.warning(f"Issue: {report['number']} - {testName}, adding a new comment was unsuccessful!")
                                            break
                    else:
                        LOGGER.error(f"Error: {response.status_code} - {response.json()}")
            
            # return existing bug report url
            LOGGER.info(f"Bug Report URL: {report['html_url']}")
            return f"{report['html_url']}"
    else:
        # new report to be written up
        # Look at adding the new reports to a new holding repo
        LOGGER.info(f"No report found for: {testName}")

        if failDetails['errorType'] == 'error':
            if 'description' in failDetails['errorDetails']:
                issue_data = {
                    "title" : f"TestFramework: [{compiler}] {failDetails["testname"]} in {failDetails["testSuite"]}, {failDetails['errorDetails']['description']}",
                    "body": f"### Workflow Artifact URL\n"
                            f"https://github.com/{repos[1]}/actions/runs/{_artifactRunID[0]}/artifacts/{_artifactID[0]}\n\n"
                            f"### Test Code\n"
                            f"```\n"
                            f"{test_code_details[0]}\n"
                            f"```\n\n"
                            f"### Output From The Test\n"
                            f"Test Name: {failDetails["testname"]}\n"
                            f"Title: {failDetails['errorDetails']['title']}\n"
                            f"Description: {failDetails['errorDetails']['description']}\n"
                            f"Expected Value: {failDetails['errorDetails']['expected']}\n"
                            f"Actual Value: {failDetails['errorDetails']['actual']}\n"
                            f"Stack: {failDetails['errorDetails']['stack']}\n\n"
                            f"### Runtime Version\n"
                            f"{RTVersion}\n\n"
                            f"### Location Of The Test\n"
                            f"{test_code_details[1]}\n\n"
                            f"### Which platform(s) are you seeing the problem on?\n"
                            f"Windows",
                    "labels": ["Testframework"],
                    "type": "In-Game Bug",
                }
            else:
                issue_data = {
                    "title" : f"TestFramework: [{compiler}] {failDetails["testname"]} in {failDetails["testSuite"]}, {failDetails['errorDetails']['message']}",
                    "body": f"### Workflow Artifact URL\n"
                            f"https://github.com/{repos[1]}/actions/runs/{_artifactRunID[0]}/artifacts/{_artifactID[0]}\n\n"
                            f"### Test Code\n"
                            f"```\n"
                            f"{test_code_details[0]}\n"
                            f"```\n\n"
                            f"### Output From The Test\n"
                            f"Test Name: {failDetails["testname"]}\n"
                            f"Error Message: {failDetails['errorDetails']['message']}\n"
                            f"### Runtime Version\n"
                            f"{RTVersion}\n\n"
                            f"### Location Of The Test\n"
                            f"{test_code_details[1]}\n\n"
                            f"### Which platform(s) are you seeing the problem on?\n"
                            f"Windows",
                    "labels": ["Testframework"],
                    "type": "In-Game Bug",
                }
        elif failDetails['errorType'] == 'exception':
            issue_data = {
                "title" : f"TestFramework: [{compiler}] {failDetails["testname"]} in {failDetails["testSuite"]}, {failDetails['errorDetails']['message']}",
                "body": f"### Workflow Artifact URL\n"
                        f"https://github.com/{repos[1]}/actions/runs/{_artifactRunID[0]}/artifacts/{_artifactID[0]}\n\n"
                        f"### Test Code\n"
                        f"```\n"
                        f"{test_code_details[0]}\n"
                        f"```\n\n"
                        f"### Output From The Test\n"
                        f"Test Name: {failDetails["testname"]}\n"
                        f"Message: {failDetails['errorDetails']['message']}\n"
                        f"Long Message: {failDetails['errorDetails']['longMessage']}\n"
                        f"Script: {failDetails['errorDetails']['script']}\n\n"
                        f"### Runtime Version\n"
                        f"{RTVersion}\n\n"
                        f"### Location Of The Test\n"
                        f"{test_code_details[1]}\n\n"
                        f"### Which platform(s) are you seeing the problem on?\n"
                        f"Windows",
                "labels": ["Testframework"],
                "type": "In-Game Bug",
            }

        url = f"https://api.github.com/repos/{repos[2]}/issues"

        response = requests.post(url, headers=headers, json=issue_data)

        if response.status_code == 201:
            issue_data = response.json()
            LOGGER.info(f"Issue: {issue_data['number']} - {testName}, successfully created!")
            LOGGER.info(f"Bug Report URL: {issue_data['url']}")
            # add 1 to the new report created count
            total_new_reports += 1
            return f"{issue_data['html_url']}"
        LOGGER.warning(f"Creating a report for {testName} failed. HTTP Status: {response.status_code}")

    return "not filed (creating the report failed)"


# search for current issue
def get_issues(repo, testName, compiler):
    """ Check if an issue with SEARCH_TERM exists in a repo """

    ENCODED_TERM = urllib.parse.quote(f"TestFramework: [{compiler}] {testName}", safe="")
    
    # search issues for exists reports
    headers = {}
    if github_token:
        headers['Authorization'] = f'Bearer {github_token}'
        headers['Accept'] = 'application/vnd.github.v3+json'

    response = requests.get(f"https://api.github.com/search/issues?q=repo:{repo}+is:issue+in:title+{ENCODED_TERM}&per_page=1&sort=created&order=desc", headers=headers, stream=True)
    
    time.sleep(2) # give the request time to fetch the result before moving on

    if response.status_code == 200:
        issues = response.json().get("items", [])
        return [response.json(), repo] if len(issues) > 0 else None


# start the comparison run
get_workflow_runs()

if PRNumber:
    if not compared:
        LOGGER.error("This run's results weren't compared, so nothing was checked")
        sys.exit(1)

    if pr_tests_incomplete:
        verdict = (f"Couldn't work out which tests pull request #{PRNumber} adds or changes, so its failures can't be "
                   "told apart from others. Re-run the job; see the log for why.")
    elif pr_touched_fails:
        verdict = (f"{len(pr_touched_fails)} failing test(s) that pull request #{PRNumber} adds or changes. "
                   "If they wait for a runtime fix, they pass once a runtime with the fix is on the feed.")
    else:
        verdict = f"No test that pull request #{PRNumber} adds or changes fails. Any other failures are listed in TF_Output.txt."

    with open("TF_Output.txt", "a") as file:
        file.write(f"\n******************************** PULL REQUEST #{PRNumber} *********************************\n")
        file.write(f"\n{verdict}\n")
        for problem in pr_tests_incomplete:
            file.write(f"\n{problem}\n")
        for fail in pr_touched_fails:
            file.write(f"\n{fail}\n")

    step_summary = os.getenv("GITHUB_STEP_SUMMARY")
    if step_summary:
        with open(step_summary, "a", encoding="utf-8") as summary:
            summary.write(f"### TF Compare\n\n{verdict}\n\n")
            for problem in pr_tests_incomplete:
                summary.write(f"- {problem}\n")
            for fail in pr_touched_fails:
                summary.write(f"- {fail}\n")

    if pr_tests_incomplete or pr_touched_fails:
        LOGGER.error(verdict)
        for problem in pr_tests_incomplete + pr_touched_fails:
            LOGGER.error(problem)
        sys.exit(1)
    LOGGER.info(verdict)
