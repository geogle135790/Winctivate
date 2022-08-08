@echo off
TITLE = Winctivate
setlocal enableDelayedExpansion

%nul% reg query HKU\S-1-5-19 || (
if not defined _elev %nul% %psc% "start cmd.exe -arg '/c \"!_PSarg:'=''!\"' -verb runas" && exit /b
%nceline%
echo This script require administrator privileges.
echo To do so, right click on this script and select 'Run as administrator'.
goto adminfailed
)

:main
cls
echo  Welcome to Winctivate
echo       Main Menu 
echo  1)Activate Windows
echo  2)Activate Office
echo  3)Credits
echo  4)Exit
echo(

:: Define all valid commands: make sure there is a space between each command
:: and also one at beginning and end
set "commands= 1 2 3 4 exit"

:input.get

:: Clear the existing value in case user hits <Enter> without entering anything
set "input="

:: Get the next command
set /p "input=Option\>"

:: Parse command into command and arguments.
for /f "tokens=1* delims= " %%A in ("!input!") do (

  REM check if command is valid (not case sensitive) and act accordingly
  if "!commands: %%A =!" equ "!commands!" (
    echo invalid selection: %%A
  ) else if /i %%A equ exit (
    exit /b
  ) else (
    call :%%A %%B
  )
)
echo(
goto input.get


:1
cls
setlocal
for /f "tokens=4-5 delims=. " %%i in ('ver') do set VERSION=%%i.%%j
if "%version%" == "10.0" goto WIN10ACTIV
if "%version%" == "6.3" goto win10activ
if "%version%" == "6.2" goto win10activ
if "%version%" == "6.1" goto win7activ
if "%version%" == "6.0" goto nsuport
rem etc etc
endlocal

:2
cls
::set "commands= 2016 2019 2022 "
echo Office not suported now
echo sorry:(
goto main

:3
cls
Echo ##############################
echo #         Winctivate         #
echo ##############################
echo #          Website:          #
echo #       Winctivate.net       #
echo ##############################



:4
echo Thans for using Winctivate
exit /b

:WIN10ACTIV
cls
echo Your Windows is 10 or 11
echo Adding Key
W269N-WFGWX-YVC9B-4J6C9-T83GX
echo  Adding Kms Server
::slmgr /skms kms.digiboy.ir
echo Trying to activate Windows via KMS server
::slmgr /ato
echo Waiting 5 second
ping 127.0.0.1 -n 5 > nul
wmic path SoftwareLicensingProduct get licensestatus | 1>nul findstr "1" && goto activated || goto win10fail

:win10fail
echo Activation Failed(or not?)
echo Trying another key
::slmgr/ipk 8DVY4-NV2MW-3CGTG-XCBDB-2PQFM
echo Trying to activate Windows via KMS server
::slmgr /ato
echo Waiting 5 second
ping 127.0.0.1 -n 5 > nul
wmic path SoftwareLicensingProduct get licensestatus | 1>nul findstr "1" && goto activated || echo Activation Failed
echo Trying another KMS server
::slmgr /skms kms.loli.best
::slmgr /ato
echo Waiting 5 second
ping 127.0.0.1 -n 5 > nul
wmic path SoftwareLicensingProduct get licensestatus | 1>nul findstr "1" && goto activated || echo Activation Failed


:winfail
echo Activation Failed
echo Try again or check internet connection
ping 127.0.0.1 -n 2 > nul
goto main

:win7activ
slmgr.vbs /ipk FJGCP-4DFJD-GJY49-VJBQ7-HYRR2
wmic path SoftwareLicensingProduct get licensestatus | 1>nul findstr "1" && goto activated || goto winfail

:activated
echo Activated:)
ping 127.0.0.1 -n 2 > nul
goto main

:nsuport
echo Your Windows not Suported(Vista or lower)
echo Sorry:(
ping 127.0.0.1 -n 2 > nul
goto main

:AdminFailed
cls
echo ==== ERROR ====
echo.
echo This script require administrator privileges.
echo To do so, right click on this script and select 'Run as administrator'.
echo.
echo Press any key to exit . . .
pause>nul
