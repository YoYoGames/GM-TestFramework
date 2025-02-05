import requests, zipfile, sys, json, os, glob
from pathlib import Path
from datetime import datetime
import argparse

# Parse command-line arguments
parser = argparse.ArgumentParser(description="GitHub Artifact Processor")
parser.add_argument('--github-token', type=str, required=True, help="GitHub token for authentication")
parser.add_argument('--workflow-choice', type=str, required=True, help="Test Framework workflow selection")
args = parser.parse_args()

# Get GitHub token from arguments
github_token = args.github_token
workflow_choice = args.workflow_choice

# this path needs to be updated to a location on server
baseSaveLocation = "C:\\Users\\ygbuild\\AppData\\Local\\Test_Framework_Artefacts_Parser"  
saveLocation = ['new_data', 'prev_data']

# declare variables
_artifactRunID = []
_download_artifacts_url = []

avail_workflows = {
    '1' : 'Beta',
    '2' : 'Monthly',
    '3' : 'Red',
    '4' : 'CI'
}

# Create new_data and prev_data directories if they don't exists
for dir in saveLocation:
    directory = Path(f"{baseSaveLocation}/{dir}")
    directory.mkdir(parents=True, exist_ok=True)

def compare_artifacts(artifact_files):

    allTestFiles = {}
    fileCount = 1
    
    # for each data directory
    for data in saveLocation:
        # for each json file
        for art_file in artifact_files:
            
            # json file location
            file_path = f"{baseSaveLocation}/{data}/{art_file}"
            # open and read the json file
            with open(file_path, 'r') as file:

                #if fileCount == 0:
                # eg. xUnit_windows_VM_1, xUnit_windows_YYC_1 - Latest Test Run
                #     xUnit_windows_VM_2, xUnit_windows_YYC_2 - Previous Test Run
                allTestFiles[f"{art_file}_{fileCount}"] = json.load(file)

        fileCount +=1

    if len(allTestFiles) > 0:
        # define variable to hold failed data
        testFails = {}
        new_skips = {}
        for index, tfData in enumerate(allTestFiles, start=1):
            for testsuite in allTestFiles[tfData]["testsuites"]:
                # check if testsuite contains any fails
                if testsuite["tallies"]["failures"] > 0 or testsuite["tallies"]["skipped"]:
                    testSuiteName = testsuite["name"]
                    # iterate through the tests
                    for test in testsuite["tests"]:
                        testResult = test["result"]
                        testName = test["name"]

                        failsIndex = f"f{index}"

                        if failsIndex not in testFails:
                            testFails[failsIndex] = {}

                        if testResult == "Failed":
                            
                            for errorDetails in test['errors']:
                                testFails[failsIndex].setdefault(testName, {
                                    "testname": testName,
                                    "testSuite": testSuiteName,
                                    "errorDetails": errorDetails
                                })
                            for exceptionDetails in test['exceptions']:
                                testFails[failsIndex].setdefault(testName, {
                                    "testname": testName,
                                    "testSuite": testSuiteName,
                                    "errorDetails": exceptionDetails
                                })
                        elif testResult == "Skipped" and index in range(1,3):
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

        # Convert artifact timestamp to readable format
        dt_object = datetime.strptime(first_fail_dict["timestamp_iso"], "%Y-%m-%dT%H:%M:%S")
        # Format it in a readable way
        file.write(f"\nArtifact Date/Time: {dt_object.strftime("%d %B, %Y at %I:%M %p")}\n")
        # total number of testsuites
        file.write(f"Total Testsuites: {len(first_fail_dict["testsuites"])}\n")
        file.write(f"Total Tests: {first_fail_dict['tallies']["tests"]}\n")
        file.write(f"Total Assertions: {first_fail_dict['tallies']["assertions"]}\n")

        file.write(f"Total Failed Tests: ({first_fail_dict['tallies']["failures"]}) = ({round((first_fail_dict['tallies']["failures"] / first_fail_dict['tallies']["tests"]) * 100, 2)})%\n")
        file.write(f"Total Skipped Tests: ({first_fail_dict['tallies']["skipped"]}) = ({round((first_fail_dict['tallies']["skipped"] / first_fail_dict['tallies']["tests"]) * 100, 2)})%\n")
        
        # iterate through each test suite
        new_fails_map = {}
        failsWrapper = [ALLFails, f1_Fails, f2_Fails]
        compiler = ["VM and YYC", "VM ONLY", "YYC ONLY"]
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

                    if "description" in failTest['errorDetails']:
                        file.write(f"\nBug Title: TestFrameWork: {failTest["testname"]} in {failTest["testSuite"]}, {failTest['errorDetails']['description']}\n")
                        # get details for all errors on each test
                        new_fails_map.setdefault(failTest["testname"], f"{failTest["testSuite"]}, {failTest['errorDetails']['description']}")
                        file.write(f"Test Name: {failTest["testname"]}\n")
                        file.write(f"Title: {failTest['errorDetails']['title']}\n")
                        file.write(f"Description: {failTest['errorDetails']['description']}\n")
                        file.write(f"Expected value: {failTest['errorDetails']['expected']}\n")
                        file.write(f"Actual value: {failTest['errorDetails']['actual']}\n")
                        file.write(f"Stack: {failTest['errorDetails']['stack']}\n")
                    else:
                        file.write(f"\nBug Title: TestFrameWork: {failTest["testname"]} in {failTest["testSuite"]}, {failTest['errorDetails']['message']}\n")
                        new_fails_map.setdefault(failTest["testname"], f"{failTest["testSuite"]}, {failTest['errorDetails']['message']}")
                        file.write(f"Test Name: {failTest["testname"]}\n")
                        file.write(f"Message: {failTest['errorDetails']['message']}\n")
                        file.write(f"Long Message: {failTest['errorDetails']['longMessage']}\n")
                        file.write(f"Script: {failTest['errorDetails']['script']}\n")
                    # increment test number by 1
                    testCounter +=1
            elif len(failsWrapper[0]) + len(failsWrapper[1]) + len(failsWrapper[2]) == 0:
                sys.exit("\nNo files found in the artifact archive.\n") # Print error details 

        file.write("\n************************************** NEW FAILS ***************************************\n")

        failcount = 0
        for new_error in new_fails_map:
            if new_error not in new_fails_map:
                file.write(f"\n{new_error}\n")
                failcount +=1
        
        if failcount == 0:
            file.write("\nNo new fails have been identified\n")

        file.write("\n**************************** RECENT FIXES TO MARK VERIFIED *****************************\n")

        fixcount = 0
        for prev_error in prev_fails_map:
            if prev_error not in new_fails_map:
                file.write(f"\n{prev_error}\n")
                fixcount +=1

        if fixcount == 0:
            file.write("\nNo fixes to verify\n")

        file.write("\n************************************ SKIPPED TESTS ************************************\n\n")

        for skipped in new_skips:
            file.write(f"{skipped} : in {new_skips[skipped]}\n")

        file.write("\n****************************************************************************************\n")
        file.write("*********************************** END OF FILTERING ***********************************\n")
        file.write("****************************************************************************************\n")


    # Remove all downloaded artifacts files
    for art_dir in saveLocation:
        directory = f"{baseSaveLocation}/{art_dir}"

        # Get all files in the directory
        files = glob.glob(os.path.join(directory, "*"))  

        for file in files:
            if os.path.isfile(file):  # Ensure it's a file (not a folder)
                os.remove(file)

    print("\nAll downloaded artifact files deleted.")
        
                                    

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
                print(f"Extracted {art_file} to {extract_to}") 
        else:
            sys.exit("No files found in the artifact archive.") # Print error details

    return artifact_files

    

def download_github_artifact():

    # iterate through the _download_artifacts_url array and download each artifact file
    urlCount = 0
    for url in _download_artifacts_url:

        save_path = f"{baseSaveLocation}/{saveLocation[urlCount]}/"

        headers = {}
        if github_token:
            headers['Authorization'] = f'Bearer {github_token}'
            headers['Accept'] = 'application/vnd.github.v3+json'

        response = requests.get(url, headers=headers, stream=True)
        
        if response.status_code == 200:
            with open(f"{save_path}artifact.zip", 'wb') as file:
                for chunk in response.iter_content(chunk_size=8192):
                    file.write(chunk)
            print(f"Download complete: {save_path}artifact.zip")

            # unzip the VM and YYC json files
            artifact_files = unzip_artifact_files(save_path, "artifact.zip")

            urlCount +=1
        else:
            print(f"Failed to download artifact. HTTP Status: {response.status_code}")
            sys.exit(response.text) # Print error details

    # time to compare the artifact files
    compare_artifacts(artifact_files)


def get_artifact_URL():

    for runid in _artifactRunID:
        artifact_url = f"https://api.github.com/repos/YoYoGames/GM-TestFramework/actions/runs/{runid}/artifacts"

        response = requests.get(artifact_url)

        if response.status_code == 200:
            # Parse the JSON response
            artifact_data = response.json()

            artifact_details = artifact_data.get("artifacts", [])

            for artifact in artifact_details:
                print(artifact.get("archive_download_url"))
                _download_artifacts_url.append(artifact.get("archive_download_url"))
        else:
            print(f"Failed to artifact URL. HTTP Status: {response.status_code}")
            sys.exit(response.text) # Print error details

    # Time to download the artifact files
    download_github_artifact()

# Get the latest 2 workflow run
def get_workflow_runs():
       
    response = requests.get(f"https://api.github.com/repos/YoYoGames/GM-TestFramework/actions/workflows/{avail_workflows[workflow_choice]}.yml/runs?status=completed&per_page=2")

    if response.status_code == 200:
        # Parse the JSON response
        artifact_data = response.json()

        workflow_runs = artifact_data.get("workflow_runs", [])

        for run in workflow_runs:
            # add workflow run id to array
            _artifactRunID.append(run.get("id"))
    
        get_artifact_URL()
    else:
        print(f"Failed to download artifact. HTTP Status: {response.status_code}")
        sys.exit(response.text) # Print error details

# start the comparison run
get_workflow_runs()
