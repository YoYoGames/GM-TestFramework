@echo off
setlocal

set "CONFIG_FILE=%1"
set "RSS_FEED=%2"

set "COMMAND=python framework_launcher.py -cf %CONFIG_FILE%"
if not "%RSS_FEED%"=="" (
    set "COMMAND=%COMMAND% -f %RSS_FEED%"
)

echo Running command: %COMMAND%
%COMMAND%