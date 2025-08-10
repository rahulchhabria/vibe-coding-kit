@echo off
REM Windows batch wrapper for WSL scripts
REM Usage: wsl-wrapper.bat <script-name>

set SCRIPT=%1
set REPO_PATH=/mnt/c/Users/%USERNAME%/Documents/vibe-coding-kit

if "%SCRIPT%"=="" (
    echo Usage: %0 script-name
    exit /b 1
)

echo Running %SCRIPT% via WSL...
wsl bash -c "cd %REPO_PATH% && ./scripts/%SCRIPT%"

if %ERRORLEVEL% neq 0 (
    echo Failed to run %SCRIPT%
    pause
    exit /b %ERRORLEVEL%
)