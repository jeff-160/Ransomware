@echo off

cd /d %~dp0

for /f "delims=" %%i in ('powershell -Command "Get-Content key.txt | ForEach-Object { $_.Trim() }"') do set "key=%%i"

for /r "%USERPROFILE%"  %%f in (*) do (
    echo %%f | findstr /i %~dp0 >nul

    if errorlevel 1 (
        openssl enc -d -aes-256-cbc -in %%f -out "%%f.temp" -pass pass:%key% -pbkdf2
        move /Y "%%f.temp" %%f >nul 2>&1
    )
)