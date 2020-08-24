@echo off
setlocal enabledelayedexpansion

rem Vagrant Box Builder
rem --- vars ------------------------------------
set BOX_NAME=%1
set BOX_FULL_NAME=private/%BOX_NAME%
rem ---------------------------------------------

rem current directory
cd %~dp0%BOX_NAME%

rem args check
if "%BOX_NAME%"=="" (
    echo Error : invalid argument.
    exit /b 0
)

rem box name vagrantfile exist check
if not exist Vagrantfile (
    echo Error : %BOX_NAME%\Vagrantfile is not found.
    exit /b 0
)

rem vagrant box exist check
echo Vagrant Box check...
vagrant box list | findstr "%BOX_FULL_NAME%"
if "%ERRORLEVEL%"=="0" (
    set BOOL=FALSE
    set /p STR_INPUT="Vagrant Box %BOX_FULL_NAME% exist. Do you want a box rebuild? (Y/N) : "
    if "!STR_INPUT!"=="y" set BOOL=TRUE
    if "!STR_INPUT!"=="Y" set BOOL=TRUE
    if !BOOL!==TRUE (
        echo Old Vagrant Box remove...
        vagrant box remove %BOX_FULL_NAME%
    ) else (
        echo Vagrant Box rebuild abort.
        exit /b 0
    )
)

rem virtual machine make
echo Vagrant Box build start...
vagrant up

rem convert to box and deploy
echo Vagrant Box package...
vagrant package --output %BOX_NAME%.box
vagrant box add %BOX_FULL_NAME% %BOX_NAME%.box

rem clean up
echo Vagrant Box build clean up...
vagrant destroy -f
rmdir /s /q .vagrant
echo Vagrant Box file %BOX_NAME%.box is Added. You don't need this file anymore, do you want to delete it?
del /p %BOX_NAME%.box

rem finish message
echo Vagrant Box has been completed.
echo Vagrant Box name: %BOX_FULL_NAME%
exit /b 0
