
@echo off
title Automatic GitHub Upload

REM Go to project folder
cd /d "C:\Users\USER\Documents\My-work"

if errorlevel 1 goto error

echo =====================================
echo       AUTOMATIC GITHUB UPLOAD
echo =====================================

REM Check Git repository
git rev-parse --is-inside-work-tree >nul 2>&1
if errorlevel 1 goto error

REM Configure new GitHub repository
git remote set-url origin https://github.com/drawingclass97-hub/Adobe_Pagemaker_My-work.git
if errorlevel 1 goto error

REM Check Git status
git status

REM Add all files
git add .
if errorlevel 1 goto error

REM Commit changes
git diff --cached --quiet
if errorlevel 1 (
    git commit -m "Automatic project update"
    if errorlevel 1 goto error
) else (
    echo No new changes to commit.
)

REM Get latest GitHub changes
git pull --rebase origin main
if errorlevel 1 goto error

REM Upload to GitHub
git push -u origin main
if errorlevel 1 goto error

echo.
echo =====================================
echo       GITHUB UPLOAD SUCCESSFUL
echo =====================================
pause
exit /b 0

:error
echo.
echo =====================================
echo       GITHUB UPLOAD FAILED
echo =====================================
echo Please check the error above.
pause
exit /b 1
