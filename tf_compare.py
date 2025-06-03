import requests, zipfile, sys, json, os, glob, re, shutil, time, fnmatch
from pathlib import Path
from datetime import datetime, timezone, timedelta
import argparse
import urllib.parse

# Parse command-line arguments
parser = argparse.ArgumentParser(description="GitHub Artifact Processor")
parser.add_argument('--github-token', type=str, required=True, help="GitHub token for authentication")
parser.add_argument('--workflow', type=str, required=True, help="Workflow file name")
parser.add_argument('--rt', type=str, required=False, help="Current Runtime Version")
args = parser.parse_args()

# Get GitHub token from arguments
github_token = args.github_token
workflow = args.workflow
RTVersion = args.rt

# this path needs to be updated to a location on server
baseSaveLocation = "C:\\Users\\ygbuild\\AppData\\Local\\Test_Framework_Artefacts_Parser"
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

time_taken = 0
total_new_reports = 0
total_reopened_reports = 0

# Create new_data and prev_data directories if they don't exists
for dir in saveLocation:
    directory = Path(f"{baseSaveLocation}/{dir}")
    directory.mkdir(parents=True, exist_ok=True)



# FUNCTION LIST:
# 1. get_workflow_runs
# 2. get_artifact_URL
# 3. download_github_artifact
# 4. unzip_artifact_files
# 5. compare_artifacts
# 6. get_issues
# 7. log_fail
# 8. get_code
                                    

# Get the latest 2 workflow run
def get_workflow_runs():

    global time_taken

    headers = {}
    if github_token:
        headers['Authorization'] = f'Bearer {github_token}'
        headers['Accept'] = 'application/vnd.github.v3+json'
      
    response = requests.get(f"https://api.github.com/repos/{repos[1]}/actions/workflows/{workflow}/runs?per_page=2", headers=headers, stream=True)

    if response.status_code == 200:
        # Parse the JSON response
        artifact_data = response.json()

        workflow_runs = artifact_data.get("workflow_runs", [])

        branch = workflow_runs[0]['head_branch']

        # Parse the ISO 8601 timestamps
        run_start = datetime.strptime(workflow_runs[0]['created_at'], '%Y-%m-%dT%H:%M:%SZ')
        run_end = datetime.strptime(workflow_runs[0]['updated_at'], '%Y-%m-%dT%H:%M:%SZ')

        # Calculate the difference
        time_taken = run_end - run_start

        # download workflow run log for new run that is currently in progress
        allowed_workflows = {'Beta', 'Monthly', 'Red'}
        
        for run in workflow_runs:
            if branch == 'develop' and run['name'] in allowed_workflows:
                # add workflow run id to array
                _artifactRunID.append(run['id'])
                
        if len(_artifactRunID) >= 1:
            get_artifact_URL()
        else:
            print("Valid workflow not used, only Beta, Monthly or Red on the develop branch is accepted for the TF Compare script")
    else:
        print(f"Failed to get workflow runs. HTTP Status: {response.status_code}")



def get_artifact_URL():

    global artifact_data_store

    for runindex, runid in enumerate(_artifactRunID, start=1):
        # track which TF run we are getting artifact details for ('Current' or 'Previous')
        runState = "Current" if runindex == 1 else "Previous"

        artifact_url = f"https://api.github.com/repos/{repos[1]}/actions/runs/{runid}/artifacts"

        response = requests.get(artifact_url)

        if response.status_code == 200:
            # Parse the JSON response
            artifact_data = response.json()

            artifact_details = artifact_data.get("artifacts", [])

            # define variable
            # summary_exists = False

            for index, artifact in enumerate(artifact_details, start=1):
                

                # Index 1 should always refer to the main artifact file (summary_file)
                # The summary_file needs to exist for the script to continue
                if index == 1 and "summary_file" in artifact.get("name"):
                    # mark that the summary_file exists and is in index 1
                    # summary_exists = True
                    # add first new run artifact id to array
                    _artifactID.append(artifact['id'])
                    _download_artifacts_url[runState] = artifact.get("archive_download_url")
                
                # only get tf_output file for current run if it already exists (re-run)
                # if summary_exists == True and index == 2 and "tf_compare" in artifact.get("name") and runState == "Current":
                #     artifact_data_store["artifact_web_download_url"] = f"https://github.com/{repos[1]}/actions/runs/{runid}/artifacts/{artifact['id']}"
        else:
            print(f"Failed to artifact URL. HTTP Status: {response.status_code}")

    # Time to download the artifact files, ensure the current run has a valid artifact file
    if (len(_download_artifacts_url) > 0) and _download_artifacts_url.get('Current'):
        download_github_artifact(_download_artifacts_url)
    else:
        print(f"No artifact files available in the current workflow run!\nTF Compare script will not continue")


def download_github_artifact(_download_artifacts_url):

    # iterate through the _download_artifacts_url array and download each artifact file
    urlCount = 0
    print("Downloading artifact files")
    
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
            print(f"Failed to download artifact. HTTP Status: {response.status_code}")

    # time to compare the artifact files
    if len(artifact_files) >= 1:
        print("Artifacts successfully downloaded")
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
            print("No files found in the artifact archive.") # Print error details

    return artifact_files



def compare_artifacts(artifact_files):

    global total_new_reports
    global total_reopened_reports
    global artifact_data_store

    allTestFiles = {}
    fileCount = 1

    print("Processing and Comparing artifact data")
    
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
                print(f"File in {file_path} does not exist.")
        fileCount +=1

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

                        if testResult.lower() == "failed":
                            
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

    newFilesToCompare = int(len(allTestFiles) / 2)

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
        for f1Fails in testFails["f1"]:
            ALLFails.append(testFails["f1"][f1Fails])

    for testRun in testFails:
        # if the last character of the of 'testRun' is not 1 then start processing
        if int(testRun[-1]) > newFilesToCompare:
            for prevTestFail in testFails[testRun]:
                prev_fails_map.setdefault(prevTestFail, testFails[testRun][prevTestFail])

    # Ouput fails
    with open("TF_Output.txt", "w") as file:

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
        file.write(f"\nTotal Run Time: {time_taken}\n")
        # total number of testsuites
        file.write(f"Total Testsuites: {len(first_fail_dict["testsuites"])}\n")
        file.write(f"Total Tests: {first_fail_dict['tallies']["tests"]}\n")
        file.write(f"Total Assertions: {first_fail_dict['tallies']["assertions"]}\n")

        file.write(f"Total Failed Tests: ({first_fail_dict['tallies']["failures"]}) = ({round((first_fail_dict['tallies']["failures"] / first_fail_dict['tallies']["tests"]) * 100, 2)})%\n")
        file.write(f"Total Skipped Tests: ({first_fail_dict['tallies']["skipped"]}) = ({round((first_fail_dict['tallies']["skipped"] / first_fail_dict['tallies']["tests"]) * 100, 2)})%\n")

        # iterate through each test suite
        new_fails_map = {}
        failsWrapper = [ALLFails, f1_Fails, f2_Fails]
        compiler = ["VM and YYC", "VM", "YYC"]
        testCounter = 1

        for cIndex, fArray in enumerate(failsWrapper, start=0):

            if len(fArray) > 0:

                file.write(f"\n********************************** {compiler[cIndex]} Fails ***********************************\n")

                # total number of failures in current test run
                file.write(f"\nTotal Failures: {len(fArray)}\n")
            
                for failTest in fArray:

                    file.write("\n----------------------------------------------------------------------------------------\n")
                    
                    file.write(f"\nFail No: {testCounter}\n")
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
                    

                    # get code
                    test_code_details = get_code(failTest["testname"], failTest["testSuite"])


                    # log fail as an issue on GitHub
                    log_fail(failTest["testname"], failTest, compiler[cIndex], test_code_details)

                    # increment test number by 1
                    testCounter +=1

            elif len(failsWrapper[0]) + len(failsWrapper[1]) + len(failsWrapper[2]) == 0:
                print(f"\nNo fails have been identified in this run for {compiler[cIndex]}.") # Print error details
                

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
        print("\nTEXT file 'TF_Output.txt' was created successfully!")


    # Remove all downloaded artifacts files
    for art_dir in saveLocation:
        directory = f"{baseSaveLocation}/{art_dir}"

        # Get all files in the directory
        files = glob.glob(os.path.join(directory, "*"))  

        for file in files:
            if os.path.isfile(file):  # Ensure it's a file (not a folder)
                os.remove(file)

    print("\nArtifact comparison has completed")
    print("All downloaded artifact files deleted.")

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
                artifact_data_store["artifact_web_download_url"] = f"https://github.com/{repos[1]}/actions/runs/{_artifactRunID[0]}/artifacts/{artifact['id']}"

    # build JSON file content for Slack Notification
    print("\nCreating Slack JSON Stats file")
    slack_stats["text"] = f"*{RTVersion} {workflow.split(".")[0]} Test Results Summary*"
    slack_stats["Runtime-Version"] = RTVersion
    slack_stats["attachments"] = [
        {
            "color": "#36a64f",
            "fields": [
                { "title": "Total Run Time", "value": f"{time_taken}", "short": True },
                { "title": "Total tests", "value": str(first_fail_dict['tallies']["tests"]), "short": True },
                { 
                    "title": "Total failed tests", 
                    "value": f"{first_fail_dict['tallies']['failures']} ({round((first_fail_dict['tallies']['failures'] / first_fail_dict['tallies']['tests']) * 100, 2)}%)", 
                    "short": True
                },
                { 
                    "title": "Total skipped tests", 
                    "value": f"{first_fail_dict['tallies']['skipped']} ({round((first_fail_dict['tallies']['skipped'] / first_fail_dict['tallies']['tests']) * 100, 2)}%)", 
                    "short": True
                },
                { "title": "Total Reports Created", "value": f"{total_new_reports}", "short": True },
                { "title": "Total Reports Reopened", "value": f"{total_reopened_reports}", "short": True },
                { 
                    "title": "Output file", 
                    "value": f"<{artifact_data_store['artifact_web_download_url']}>", 
                    "short": False
                }
            ]
        }
    ]

    # write slack stats json file
    with open("slack_stats.json", "w") as slackfile:
        # Convert the list to a JSON-formatted string
        json.dump(slack_stats, slackfile, indent=4)
        print("\nJSON file 'slack_stats.json' was created successfully!")


#Get failed test code block and lines
def get_code(testname, testsuite):

    headers = {}
    if github_token:
        headers['Authorization'] = f'Bearer {github_token}'
        headers['Accept'] = 'application/vnd.github+json'

     # Define repo and file info
    BRANCH = "develop"
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
            print("Function not found in file.")
    else:
        print(f"Failed to fetch file. HTTP Status: {response.status_code}")


# create new bug report / comment on existing report
def log_fail(testName, failDetails, compiler, test_code_details):

    global total_new_reports
    global total_reopened_reports

    # ENCODED_TERM = urllib.parse.quote(f"{compiler} {testName}", safe="")
    
    # search issues for exists reports
    headers = {}
    if github_token:
        headers['Authorization'] = f'Bearer {github_token}'
        headers['Accept'] = 'application/vnd.github.v3+json'

    # Search all repositories
    print(f"\nSearching for test: {testName}")
    issue_search = next((data for repo in repos if (data := get_issues(repo, testName, compiler))), None)


    if issue_search != None:
        print(f"Report has been found for: {testName} in Repo: {issue_search[1]}")
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
                    print("This issue is currently marked as closed!")
                    print(f"Issue: {report['number']} - {testName}, successfully reopened")
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
                        print(f"Issue: {report['number']} - {testName}, new comment successfully added to report")
                    else:
                        print(f"Issue: {report['number']} - {testName}, adding a new comment was unsuccessful!")
                else:
                    print(f"Issue: {report['number']} - {testName}, could not be reopened")
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

                                        response = requests.post(report['comments_url'], headers=headers, json=comment_data)

                                        if response.status_code == 201:
                                            print(f"\nIssue: {report['number']} - {testName}, new comment successfully added to report")
                                        else:
                                            print(f"\nIssue: {report['number']} - {testName}, adding a new comment was unsuccessful!")
                    else:
                        print(f"Error: {response.status_code} - {response.json()}")
    else:
        # new report to be written up
        # Look at adding the new reports to a new holding repo
        print(f"No report found for: {testName}")

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
                    #"assignee" : "username"
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
                    #"assignee" : "username"
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
                        f"Windows"
                #"assignee" : "username"
            }

        url = f"https://api.github.com/repos/{repos[2]}/issues"

        response = requests.post(url, headers=headers, json=issue_data)

        if response.status_code == 201:
            issue_data = response.json()
            print(f"Issue: {issue_data['number']} - {testName}, successfully created!")
            # add 1 to the new report created count
            total_new_reports += 1


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
