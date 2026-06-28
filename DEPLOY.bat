@echo off
title Deploy Portfolio to GitHub Pages
color 0B

echo.
echo  =====================================================
echo   PORTFOLIO DEPLOYMENT - bousnina-loujein.github.io
echo  =====================================================
echo.

:: Refresh PATH to include gh CLI
set "PATH=%PATH%;C:\Program Files\GitHub CLI\"

:: Check gh is available
gh --version >nul 2>&1
if errorlevel 1 (
    echo  [ERROR] GitHub CLI not found. Please restart and try again.
    pause
    exit /b
)

echo  [1/4] Logging into GitHub...
echo  A browser window will open. Log in with your GitHub account.
echo  (if already logged in, this step will be skipped)
echo.
gh auth login --hostname github.com --git-protocol https --web

echo.
echo  [2/4] Creating repository "bousnina-loujein.github.io"...
gh repo create bousnina-loujein.github.io --public --description "My personal portfolio - Embedded Systems and IoT Engineer" 2>nul
if errorlevel 1 (
    echo  Repository may already exist - continuing...
)

echo.
echo  [3/4] Pushing portfolio to GitHub...
git remote remove origin 2>nul
git remote add origin https://github.com/bousnina-loujein/bousnina-loujein.github.io.git
git branch -M main
git push -u origin main

echo.
echo  [4/4] Enabling GitHub Pages...
gh api repos/bousnina-loujein/bousnina-loujein.github.io/pages --method POST --field source[branch]=main --field source[path]=/ 2>nul
if errorlevel 1 (
    echo  Pages may already be enabled - continuing...
)

echo.
echo  =====================================================
echo   DONE! Your portfolio will be live in 1-2 minutes:
echo.
echo   https://bousnina-loujein.github.io
echo.
echo   Open the link above in any browser or device!
echo  =====================================================
echo.
pause
