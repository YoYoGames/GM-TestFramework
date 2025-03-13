@echo off
setlocal EnableDelayedExpansion

:: Check if .venv folder exists
if not exist ".venv" (
    echo Creating virtual environment...
    python -m venv .venv
    if %ERRORLEVEL% NEQ 0 (
        echo Failed to create virtual environment. Exiting...
        exit /b 1
    )
)

:: Activate the virtual environment
echo Initializing python environment
call .venv\Scripts\activate

:: Check if the virtual environment was activated
if "%VIRTUAL_ENV%"=="" (
    echo Failed to activate virtual environment. Exiting...
    exit /b 1
) else (
    echo Virtual environment activated.
)

:: Install requirements
if exist "requirements.txt" (
    echo Installing requirements...
    pip install -r requirements.txt
    if %ERRORLEVEL% NEQ 0 (
        echo Failed to install requirements. Exiting...
        exit /b 1
    ) else (
        echo Requirements installed successfully.
    )
) else (
    echo No requirements.txt found. Skipping installation of dependencies.
)

:: Initialize activity timestamp file
set "activity_file=activity_timestamp.txt"
echo %TIME% > %activity_file%

:: Start the activity checker in the background
start "" cmd /c call :ActivityChecker

:: Function to update activity timestamp
:TrackActivity
echo %TIME% > %activity_file%
goto :EOF

:: Run your Python script
echo Running launcher.py...
python launcher.py %*
if %ERRORLEVEL% NEQ 0 (
    echo launcher.py script failed. Exiting...
    exit /b 1
) else (
    echo launcher.py finished successfully.
)

:: Deactivate the virtual environment
deactivate

:: Stop the activity checker
echo Stopping activity checker...
taskkill /IM cmd.exe /FI "WINDOWTITLE eq ActivityChecker"

echo Done!
exit /b

:: Activity checker function
:ActivityChecker
set "maxIdleTime=60"

:CheckActivity
:: Get current time
for /F "tokens=1-2 delims=:" %%A in ("%TIME%") do (
    set /A "current_time=%%A*3600+%%B*60"
)

:: Get last activity time
for /F "tokens=1-2 delims=:" %%A in ('type %activity_file%') do (
    set /A "last_activity_time=%%A*3600+%%B*60"
)

:: Calculate elapsed time
set /A "elapsed_time=current_time-last_activity_time"
if !elapsed_time! GEQ !maxIdleTime! (
    echo No activity for !elapsed_time! seconds, exiting script...
    taskkill /F /IM python.exe
    exit /b 1
)

:: Wait for 30 seconds and check again
ping -n 31 127.0.0.1 >nul
goto CheckActivity