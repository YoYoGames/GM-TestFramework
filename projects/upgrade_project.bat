@echo off
REM Enable delayed variable expansion for accurate variable handling within loops
setlocal enabledelayedexpansion

REM Set default PROJECTTOOL if not already set
if "%PROJECTTOOL%" == "" set "PROJECTTOOL=C:\Source\ProjectTool\Source\bin\Debug\net8.0\ProjectTool"

REM Check if CORERESOURCES_DLL is set
if "%CORERESOURCES_DLL%" == "" (
    echo "Environment variable CORERESOURCES_DLL is not set. Skipping conversion!"
    exit /b 0
)

REM Navigate to the directory where the script is located
pushd "%~dp0" || (
    echo "[ERROR] Failed to navigate to script directory."
    exit /b 1
)
set "BASE=%cd%"

REM Create Prefabs directory if it doesn't exist
if not exist "Prefabs" (
    mkdir "Prefabs"
    if !errorlevel! neq 0 (
        echo "[ERROR] Failed to create Prefabs directory."
        popd
        exit /b 1
    )
) else (
    echo "[INFO] Prefabs directory already exists."
)

REM Run ProjectTool to save versioned types
"%PROJECTTOOL%" SHOWVERSIONEDTYPES DESTINATION=resourceslist.json SOURCE="%CORERESOURCES_DLL%"
if !errorlevel! neq 0 (
    echo "[ERROR] ProjectTool failed while saving versioned types."
    popd
    exit /b 1
) else (
    echo "[SUCCESS] ProjectTool saving versioned types completed successfully."
)

REM Iterate through each subdirectory
for /d %%p in (*) do (
    REM Check if %%p is a directory
    if exist "%%p\" (
        echo "[INFO] Processing directory: %%p"
        pushd "%%p" >nul

        REM Check if the .yyp file exists
        if exist "%%p.yyp" (
            echo "[INFO] [%DATE% %TIME%] Processing file: %%p.yyp in directory: %%p"
            "%PROJECTTOOL%" project save source=".\\%%p.yyp" RESOURCETYPESPATH="%BASE%\\resourceslist.json" PREFABSFOLDER="%BASE%\\Prefabs"
            if !errorlevel! neq 0 (
                echo "[ERROR] [%DATE% %TIME%] Failed to save project for: %%p.yyp"
            ) else (
                echo "[SUCCESS] [%DATE% %TIME%] Project saved successfully for: %%p.yyp"
            )
        ) else (
            echo "[WARNING] [%DATE% %TIME%] File \"%%p.yyp\" does not exist in directory: %%p"
        )

        REM Return to the base directory
        popd >nul
    ) else (
        echo "[INFO] Skipping non-directory item: %%p"
    )
)

REM Clean up generated files and directories
cd "%BASE%"
del /f /q "resourceslist.json" >nul 2>&1
rmdir /s /q "Prefabs" >nul 2>&1
if !errorlevel! neq 0 (
    echo "[WARNING] Failed to delete Prefabs directory or it does not exist."
) else (
    echo "[INFO] Cleaned up resourceslist.json and Prefabs directory."
)

REM Return to the original directory
popd >nul

endlocal
echo "[DONE] Batch processing completed."
