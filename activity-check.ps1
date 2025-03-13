$maxIdleTime = 60  # Max idle time in seconds (e.g., 60 seconds)
$lastActivityTime = Get-Date

# Function to check for inactivity
function Check-Activity {
    $currentTime = Get-Date
    $elapsedTime = ($currentTime - $lastActivityTime).TotalSeconds
    Write-Host "Checking activity... Elapsed time: $elapsedTime seconds."
    if ($elapsedTime -ge $maxIdleTime) {
        Write-Host "No activity for $elapsedTime seconds, exiting script..."
        Stop-Process -Id $launcherProcess.Id  # Stop the launcher process if idle
        exit 1  # Exit the script if idle
    }
}

# Function to track activity and reset timer
function Track-Activity {
    $global:lastActivityTime = Get-Date  # Use global scope to update the variable
    Write-Host "Activity detected, timer reset to $global:lastActivityTime"
}

# Register an event to track activity (for example, by monitoring output from the tests)
Register-EngineEvent -SourceIdentifier "TestActivity" -Action { Track-Activity }

# Start your original command and get process information
Write-Host "Starting the command..."
$launcherProcess = Start-Process -FilePath ".\launcher" -ArgumentList "igorRunTests --config-file C:\GM-TestFramework\configs\${{ github.event.inputs.CONFIG_FILE }} --feed ${{ secrets.RSS_FEED_RED }} ${{ github.event.inputs.EXTRA_PARAMS }} --runtime-version ${{ github.event.inputs.RUNTIME_VERSION }}" -PassThru

# Function to monitor the launcher process
function Monitor-Process {
    while ($launcherProcess.HasExited -eq $false) {
        Check-Activity
        Start-Sleep -Seconds 30
    }
    Write-Host "Launcher process has exited."
}

# Start monitoring the process
Monitor-Process