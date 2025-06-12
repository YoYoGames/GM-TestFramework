import os, json, requests
import argparse

# Define the directory path and file path
dir_path = ""
file_path = os.path.join(dir_path, "slack_stats.json")
new_output_link = "<https://example.com/new-output-file>"
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

try:

    response = requests.get(f"https://api.github.com/repos/YoYoGames/GM-TestFramework/actions/workflows/{workflow}/runs?per_page=1", headers=headers, stream=True)

    if response.status_code == 200:
        # Parse the JSON response
        artifact_data = response.json()
        for run in artifact_data['workflow_runs']:
            artifactRunID = run['id']

    artifact_url = f"https://api.github.com/repos/YoYoGames/GM-TestFramework/actions/runs/{artifactRunID}/artifacts"
    response = requests.get(artifact_url)
    if response.status_code == 200:
        # Parse the JSON response
        artifact_data = response.json()
        artifact_details = artifact_data.get("artifacts", [])
        for artifact in artifact_details:          
            # only get tf_output file for current run if it already exists (re-run)
            if "tf_compare" in artifact.get("name"):
                new_output_link = f"https://github.com/YoYoGames/GM-TestFramework/actions/runs/{artifactRunID}/artifacts/{artifact['id']}"

    # Load the JSON data from the file
    with open(file_path, "r") as file:
        data = json.load(file)

    # Update the value
    for field in data["attachments"][0]["fields"]:
        if field["title"] == "Output file":
            field["value"] = f"<{new_output_link}>"
            break

    # Save the updated JSON back to the file
    with open(file_path, "w") as file:
        json.dump(data, file, indent=4)

    print("Update successful.")

except Exception as e:
    print({"error": str(e)})
