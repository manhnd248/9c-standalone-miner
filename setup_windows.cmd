@echo off

net.exe session 1>NUL 2>NUL || (Echo This script requires elevated rights. & Exit /b 1)

set DIR_WSL="C:\Windows\System32\wsl.exe"
set DIR_CHOCO="%ALLUSERSPROFILE%\chocolatey\choco.exe"
set DIR_DOCKER="C:\Program Files\Docker\Docker\Docker Desktop.exe"
set DIR_COMPOSE="C:\Program Files\Docker\Docker\resources\bin\docker-compose"

echo --------------------------------------------
echo  9C-STANDALONE-MINER - WINDOWS 10 SETUP
echo --------------------------------------------

:HEALTH_CHECK
echo  -Checking Prerequisites
REM Checking for WSL
if exist ".reboot" (
    echo    --WSL: Resuming
    set WSL=false
    del ".reboot" >nul 2>&1
) else (
    if exist %DIR_WSL% (
        echo    --WSL: Installed
        set WSL=true
    ) else (
        echo    --WSL: Not Installed
        set WSL=false
        type NUL > .reboot
    )
)
REM Checking for chocolatey
if exist %DIR_CHOCO% (
    echo    --Chocolatey: Installed
    set CHOCO=true
) else (
    echo    --Chocolatey: Not Installed
    set CHOCO=false
)
REM Checking for docker
if exist %DIR_DOCKER% (
    echo    --Docker: Installed
    set DOCKER=true
) else (
    echo    --Docker: Not Installed
    set DOCKER=false
)
REM Checking for docker-compose
if exist %DIR_COMPOSE% (
    echo    --Docker-Compose: Installed
    set COMPOSE=true
) else (
    echo    --Docker-Compose: Not Installed
    set COMPOSE=false
)
goto InstallWSL

:InstallWSL
if %WSL% == false (
    echo.
    echo  -WSL: Installing...
    echo -------------------------------------
    powershell.exe -noprofile -executionpolicy bypass -file .\win10-scripts\WSL2_install.ps1
    echo -------------------------------------
    if exist ".reboot" (
        goto RebootRequired 
    ) else (
        echo  -WSL: Finished
        goto InstallChocolatey
    )
)

:InstallChocolatey
if %CHOCO% == false (
    echo.
    echo  -Chocolatey: Installing...
    echo -------------------------------------
    @"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "[System.Net.ServicePointManager]::SecurityProtocol = 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"
    echo -------------------------------------
    echo  -Chocolatey: Finished
)
goto InstallDocker

:InstallDocker
if %DOCKER% == false (
    echo.
    echo  -Docker and Compose: Installing...
    echo -------------------------------------
    choco install docker-desktop
    echo -------------------------------------
    echo  -Docker and Compose: Finished
)
goto PrepareWSL

:RebootRequired
echo.
echo  Installing WSL is a 2 part process, which requires a reboot to finish.
echo  Please reboot your PC and run this script again to complete installation!
echo.
pause 
EXIT /B 

:PrepareWSL
echo.
echo --------------------------------------------
echo  WSL: DOCKER - SETUP
echo --------------------------------------------
echo.
echo Please enter the password you selected during the Distro Account Creationz
bash -c "sudo apt update && sudo apt upgrade && sudo apt install git unzip zip curl"
bash -c "cd $HOME && git clone https://github.com/CryptoKasm/9c-standalone-miner.git"
goto End

:End
echo.
echo --------------------------------------------
echo  WINDOWS 10 SETUP - COMPLETE
echo --------------------------------------------
echo.

pause