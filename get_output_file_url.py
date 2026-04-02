import logging
import os, json, requests, time
import argparse

logging.basicConfig(level=logging.INFO, format='%(asctime)s [%(levelname)s]: %(message)s', datefmt='%Y-%m-%d %H:%M:%S')
LOGGER = logging.getLogger(__name__)

# Define the directory path and file path
dir_path = ""
slack_file_path = os.path.join(dir_path, "slack_stats.json")
output_file_path = os.path.join(dir_path, "TF_Output.txt")
new_output_link = ""
artifactRunID = 0

parser = argparse.ArgumentParser(description="GitHub Artifact Processor")
parser.add_argument('--github-token', type=str, required=True, help="GitHub token for authentication")
parser.add_argument('--workflow', type=str, required=True, help="Workflow file name")
parser.add_argument('--rt', type=str, required=False, help="Current Runtime Version")
args = parser.parse_args()

github_token = args.github_token
workflow = args.workflow



headers = {}
if github_token:
    headers['Authorization'] = f'Bearer {github_token}'
    headers['Accept'] = 'application/vnd.github.v3+json'

# Check if path exists (could be a file or directory)
if os.path.exists(output_file_path):
    LOGGER.info("TF Output file located.")

    # keep waiting until the output file artifact is ready
    def wait_for_artifact_ready(artifact_id, token, timeout=60, interval=5):
        """
        Waits until the artifact is downloadable or timeout occurs.
        """
        headers = {
            "Authorization": f"Bearer {token}",
            "Accept": "application/vnd.github+json"
        }

        url = f"https://api.github.com/repos/YoYoGames/GM-TestFramework/actions/runs/{artifactRunID}/artifacts"

        start_time = time.time()
        while time.time() - start_time < timeout:
            response = requests.get(url, headers=headers)

            if response.status_code == 200:
                artifact_data = response.json()
                artifact_details = artifact_data.get("artifacts", [])
                # if artifact_data.get("expired") is False:
                for artifact in artifact_details:          
                    # only get tf_output file for current run if it already exists (re-run)
                    if "tf_compare" in artifact.get("name"):
                        return f"https://github.com/YoYoGames/GM-TestFramework/actions/runs/{artifactRunID}/artifacts/{artifact['id']}"
            elif response.status_code == 404:
                # Artifact not found yet – keep trying
                pass
            else:
                LOGGER.error(f"Unexpected error: {response.status_code}")
                return False

            LOGGER.info("Waiting for artifact to be ready...")
            time.sleep(interval)

        LOGGER.warning("Timeout: Artifact not ready in time.")
        return False


    try:
        response = requests.get(f"https://api.github.com/repos/YoYoGames/GM-TestFramework/actions/workflows/{workflow}/runs?per_page=1", headers=headers, stream=True)

        if response.status_code == 200:
            # Parse the JSON response
            artifact_data = response.json()
            for run in artifact_data['workflow_runs']:
                artifactRunID = run['id']

        new_output_link = wait_for_artifact_ready(artifactRunID, github_token)

        if (new_output_link):

            # Load the JSON data from the file
            with open(slack_file_path, "r") as file:
                data = json.load(file)

            # Update the value
            for field in data["attachments"][0]["fields"]:
                if field["title"] == "Output file":
                    LOGGER.info(f"Output file URL: {new_output_link}")
                    field["value"] = new_output_link
                    break

            # Save the updated JSON back to the file
            with open(slack_file_path, "w") as file:
                json.dump(data, file, indent=4)

            LOGGER.info("Slack Stats JSON updated successfully.")

    except Exception as e:
        LOGGER.error({"error": str(e)})
else:
    LOGGER.warning("TF Output file does not exist.")



