@echo off
:: Check if .venv folder exists
if not exist ".venv" (
    echo Creating virtual environment...
    python -m venv .venv
)

:: Activate the virtual environment
echo Initializing python environment
call .venv\Scripts\activate

:: Install requirements
if exist "requirements.txt" (
    echo Installing requirements...
    pip install -r requirements.txt
) else (
    echo No requirements.txt found. Skipping installation of dependencies.
)

:: Run your Python script
python launcher.py %*

:: Deactivate the virtual environment
deactivate

echo Done!