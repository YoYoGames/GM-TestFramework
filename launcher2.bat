@echo off
setlocal enabledelayedexpansion

REM ==============================================================================
REM launcher2 - uv-based launcher for GM-TestFramework
REM ==============================================================================

SET "SCRIPT_DIR=%~dp0"
SET "UV_PROJECT_ENVIRONMENT=%SCRIPT_DIR%.venv"
IF NOT DEFINED UV_CACHE_DIR SET "UV_CACHE_DIR=%SCRIPT_DIR%.uv\.uv_cache"
SET "_LAUNCHER_UV_VERSION=0.10.8"

REM Check if uv is already available on PATH
where uv >NUL 2>&1
IF NOT ERRORLEVEL 1 (
    REM uv found on PATH, use it directly
    goto :run
)

REM uv not on PATH, check local install
SET "UV_INSTALL_DIR=%SCRIPT_DIR%.uv"
SET "PATH=%UV_INSTALL_DIR%;%PATH%"

IF EXIST "%UV_INSTALL_DIR%\uv.exe" (
    REM uv found under local install
    goto :run
)

REM Install uv locally
echo uv not found, installing to "%UV_INSTALL_DIR%"...

IF "%PROCESSOR_ARCHITECTURE%"=="ARM64" (
    SET "UV_ARCH=aarch64-pc-windows-msvc"
) ELSE (
    SET "UV_ARCH=x86_64-pc-windows-msvc"
)

mkdir "%UV_INSTALL_DIR%" 2>NUL
curl.exe -LSsf https://github.com/astral-sh/uv/releases/download/%_LAUNCHER_UV_VERSION%/uv-!UV_ARCH!.zip -o "%UV_INSTALL_DIR%\uv-windows.zip" || (
    echo Failed to download uv release.
    exit /b 1
)

REM Extract the zip file using tar (built into Windows 10+)
tar -xf "%UV_INSTALL_DIR%\uv-windows.zip" -C "%UV_INSTALL_DIR%"
del "%UV_INSTALL_DIR%\uv-windows.zip"

IF NOT EXIST "%UV_INSTALL_DIR%\uv.exe" (
    echo uv installation failed. Please install uv manually: https://docs.astral.sh/uv/getting-started/installation/
    exit /b 1
)

echo uv installed successfully.

:run
uv run python %SCRIPT_DIR%launcher.py %*
