import requests, zipfile, sys, json, os, glob
from pathlib import Path
from datetime import datetime
import argparse

# Parse command-line arguments
parser = argparse.ArgumentParser(description="GitHub Artifact Processor")
parser.add_argument('--github-token', type=str, required=True, help="GitHub token for authentication")
args = parser.parse_args()

# Get GitHub token from arguments
github_token = args.github_token

# this path needs to be updated to a location on server
baseSaveLocation = "C:\Users\ygbuild\AppData\Local\Test_Framework_Artefacts_Parser"  
saveLocation = ['new_data', 'prev_data']

# declare variables
_artifactRunID = []
_download_artifacts_url = []

avail_workflows = {
    '1' : 'Beta',
    '2' : 'Monthly',
    '3' : 'Red'
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
                                    "testSuite": testSuiteName,  # Proper key-value pair
                                    "errorDetails": errorDetails
                                })
                            for exceptionDetails in test['exceptions']:
                                testFails[failsIndex].setdefault(testName, {
                                    "testname": testName,
                                    "testSuite": testSuiteName,  # Proper key-value pair
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
    print("\n****************************************************************************************")
    print("******************************* TEST FRAMEWORK FAILURES ********************************")
    print("****************************************************************************************\n")

    # get first fails dict
    first_fail_dict = allTestFiles[next(iter(allTestFiles))]

    # Convert artifact timestamp to readable format
    dt_object = datetime.strptime(first_fail_dict["timestamp_iso"], "%Y-%m-%dT%H:%M:%S")
    # Format it in a readable way
    print(f"Artifact Date/Time: {dt_object.strftime("%d %B, %Y at %I:%M %p")}\n")
    # total number of testsuites
    print(f"Total Testsuites: {len(first_fail_dict["testsuites"])}")
    print(f"Total Tests: {first_fail_dict['tallies']["tests"]}")
    print(f"Total Assertions: {first_fail_dict['tallies']["assertions"]}\n")

    print(f"Total Failed Tests: ({first_fail_dict['tallies']["failures"]}) = ({round((first_fail_dict['tallies']["failures"] / first_fail_dict['tallies']["tests"]) * 100, 2)})%")
    print(f"Total Skipped Tests: ({first_fail_dict['tallies']["skipped"]}) = ({round((first_fail_dict['tallies']["skipped"] / first_fail_dict['tallies']["tests"]) * 100, 2)})%")
    #print(f"Total Errors: {first_fail_dict['tallies']["errors"]}")
    

    # iterate through each test suite
    new_fails_map = {}
    failsWrapper = [ALLFails, f1_Fails, f2_Fails]
    compiler = ["VM and YYC", "VM ONLY", "YYC ONLY"]

    for cIndex, fArray in enumerate(failsWrapper, start=0):

        if len(fArray) > 0:

            print(f"\n********************************** {compiler[cIndex]} Fails ***********************************\n")

            # total number of failures in current test run
            print(f"Total Failures: {len(fArray)}\n")
        
            for failTest in fArray:

                print("----------------------------------------------------------------------------------------\n")

                print(f"Testsuite Name: {failTest["testSuite"]}")

                if "description" in failTest['errorDetails']:
                    print(f"Bug Title: TestFrameWork: {failTest["testname"]} in {failTest["testSuite"]}, {failTest['errorDetails']['description']}")

                    # get details for all errors on each test
                    #for errorDetails in failTest['errorDetails']:
                    new_fails_map.setdefault(failTest["testname"], f"{failTest["testSuite"]}, {failTest['errorDetails']['description']}")
                    print(f"Test Name: {failTest["testname"]}")
                    print(f"Title: {failTest['errorDetails']['title']}")
                    print(f"Description: {failTest['errorDetails']['description']}")
                    print(f"Expected value: {failTest['errorDetails']['expected']}")
                    print(f"Actual value: {failTest['errorDetails']['actual']}")
                    print(f"Stack: {failTest['errorDetails']['stack']}\n")
                else:
                    print(f"Bug Title: TestFrameWork: {failTest["testname"]} in {failTest["testSuite"]}, {failTest['errorDetails']['message']}")

                    #for exceptionDetails in failTest['errorDetails']:
                    new_fails_map.setdefault(failTest["testname"], f"{failTest["testSuite"]}, {failTest['errorDetails']['message']}")
                    print(f"Test Name: {failTest["testname"]}")
                    print(f"Message: {failTest['errorDetails']['message']}")
                    print(f"Long Message: {failTest['errorDetails']['longMessage']}")
                    print(f"Script: {failTest['errorDetails']['script']}\n")    
        elif len(failsWrapper[0]) + len(failsWrapper[1]) + len(failsWrapper[2]) == 0:
            sys.exit("No files found in the artifact archive.") # Print error details 

    #check_new_errors(prev_fails_map, new_fails_map)
    print("\n******************************* NEW FAILS HAVE OCCURRED *******************************\n")

    failcount = 0
    for new_error in new_fails_map:
        if new_error not in new_fails_map:
            print(new_error)
            failcount +=1
    
    if failcount == 0:
        print("No new fails have been identified")
            

    #print("\n****************************************************************************************\n")

    #check_for_fixed_errors(prev_fails_map, new_fails_map)
    print("\n***************************** VERIFY THESE HAS BEEN FIXED ******************************\n")

    fixcount = 0
    for prev_error in prev_fails_map:
        if prev_error not in new_fails_map:
            print(prev_error)
            fixcount +=1

    if fixcount == 0:
        print("No fixes to verify")

    #print("\n****************************************************************************************\n")

    #display_skipped_errors(new_skips)
    print("\n************************************ SKIPPED FAILS ************************************\n")

    for skipped in new_skips:
        print(f"{skipped} : in {new_skips[skipped]}")

    print("\n****************************************************************************************")
    print("*********************************** END OF FILTERING ***********************************")
    print("****************************************************************************************\n")


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
    # User to select desired workflow
    print("\nPlease select a workflow:")
    for workflow in avail_workflows:
        print(f"{workflow} : {avail_workflows[workflow]}")

    workflow_user_input = input("\nWorkflow selection: ")
    
    response = requests.get(f"https://api.github.com/repos/YoYoGames/GM-TestFramework/actions/workflows/{avail_workflows[workflow_user_input]}.yml/runs?status=completed&per_page=2")

    if response.status_code == 200:
        # Parse the JSON response
        artifact_data = response.json()

        workflow_runs = artifact_data.get("workflow_runs", [])

        for run in workflow_runs:
            # add workflow run id to array
            _artifactRunID.append(run.get("id"))

            #print(f"Run ID: {run_id}, Status: {status}, Conclusion: {conclusion}, Created At: {created_at}")
    
        get_artifact_URL()
    else:
        print(f"Failed to download artifact. HTTP Status: {response.status_code}")
        sys.exit(response.text) # Print error details

# start the comparison run
get_workflow_runs()
