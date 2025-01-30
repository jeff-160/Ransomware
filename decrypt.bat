@echo off

cd /d %~dp0

set key=eyeofrah

for /r "%USERPROFILE%\documents\test"  %%f in (*) do (
    openssl enc -d -aes-256-cbc -in %%f -out "%%f.temp" -pass pass:%key% -pbkdf2
    move /Y "%%f.temp" %%f >nul 2>&1
)