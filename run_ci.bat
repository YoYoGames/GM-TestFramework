@echo off
setlocal

set "CONFIG_FILE=%1"
set "RSS_FEED=%2"
set "EXTRA_PARAMS=%3"

set "COMMAND=python launcher.py -cf %CONFIG_FILE%"
if not "%RSS_FEED%"=="" (
    set "COMMAND=%COMMAND% -f %RSS_FEED%"
)

if not "%EXTRA_PARAMS%"=="" (
    set "COMMAND=%COMMAND% %EXTRA_PARAMS%"
)

echo Running command: %COMMAND%
%COMMAND%


