 @echo off
 CLS
 ECHO.
 ECHO =============================
 ECHO Accept The Prompt
 ECHO =============================

:init
 setlocal DisableDelayedExpansion
 set cmdInvoke=1
 set winSysFolder=System32
 set "batchPath=%~0"
 for %%k in (%0) do set batchName=%%~nk
 set "vbsGetPrivileges=%temp%\OEgetPriv_%batchName%.vbs"
 setlocal EnableDelayedExpansion

:checkPrivileges
  NET FILE 1>NUL 2>NUL
  if '%errorlevel%' == '0' ( goto gotPrivileges ) else ( goto getPrivileges )

:getPrivileges
  if '%1'=='ELEV' (echo ELEV & shift /1 & goto gotPrivileges)
  ECHO.
  ECHO **************************************
  ECHO Accept The Prompt
  ECHO **************************************
  ECHO Set UAC = CreateObject^("Shell.Application"^) > "%vbsGetPrivileges%"
  ECHO args = "ELEV " >> "%vbsGetPrivileges%"
  ECHO For Each strArg in WScript.Arguments >> "%vbsGetPrivileges%"
  ECHO args = args ^& strArg ^& " "  >> "%vbsGetPrivileges%"
  ECHO Next >> "%vbsGetPrivileges%"

  if '%cmdInvoke%'=='1' goto InvokeCmd 

  ECHO UAC.ShellExecute "!batchPath!", args, "", "runas", 1 >> "%vbsGetPrivileges%"
  goto ExecElevation

:InvokeCmd
  ECHO args = "/c """ + "!batchPath!" + """ " + args >> "%vbsGetPrivileges%"
  ECHO UAC.ShellExecute "%SystemRoot%\%winSysFolder%\cmd.exe", args, "", "runas", 1 >> "%vbsGetPrivileges%"

:ExecElevation
 "%SystemRoot%\%winSysFolder%\WScript.exe" "%vbsGetPrivileges%" %*
 exit /B

:gotPrivileges
 setlocal & cd /d %~dp0
 if '%1'=='ELEV' (del "%vbsGetPrivileges%" 1>nul 2>nul  &  shift /1)


:MainMenu

cls
title  WINDOWS TWEAKS AND FIXES - RAWR
mode 78, 15

echo:
echo:
echo:       ______________________________________________________________
echo:
echo:             [1] FIXES
echo:             _____________________________________________________
echo:
echo:             [2] UTILITIES
echo:       ______________________________________________________________
echo:
echo:
echo:
echo:            "Enter a menu option on the Keyboard [1,2] :"
choice /C:12 /N
set _erl=%errorlevel%

if %_erl%==2 setlocal & call :utilities & cls & endlocal & goto :MainMenu
if %_erl%==1 setlocal & call :fixes & cls & endlocal & goto :MainMenu

::========================================================================================================================================

:fixes
cls
mode 80, 28

echo:
echo:
echo:             _____________________________________________________
echo:
echo:             [1] SFC AND DISM
echo:             _____________________________________________________
echo:
echo:             [2] SFC ONLY
echo:             _____________________________________________________
echo:
echo:             [3] CHKDSK 
echo:             _____________________________________________________
echo:
echo:             [4] NETWORKING FIXES
echo:             _____________________________________________________
echo:
echo:             [5] RESTART WINDOWS UPDATE SERVICE
echo:             _____________________________________________________
echo:
echo:             [6] BACK
echo:             _____________________________________________________
echo:
echo:
echo:
echo:            "Enter a menu option on the Keyboard [1,2,3,4,5,6] :"
choice /C:123456 /N
set _erl=%errorlevel%

if %_erl%==6 setlocal & call :MainMenu & cls & endlocal & goto :fixes
if %_erl%==5 setlocal & call :update & cls & endlocal & goto :fixes
if %_erl%==4 setlocal & call :networking & cls & endlocal & goto :fixes
if %_erl%==3 setlocal & call :chkdsk & cls & endlocal & goto :fixes
if %_erl%==2 setlocal & call :sfc & cls & endlocal & goto :fixes
if %_erl%==1 setlocal & call :sfcdism & cls & endlocal & goto :fixes

::========================================================================================================================================

:utilities
cls
mode 80, 31

echo:
echo:
echo:             _____________________________________________________
echo:
echo:             [1] DEBLOATER 
echo:             _____________________________________________________
echo:
echo:             [2] RESTORE WIN 10 DESKTOP RIGHT CLICK MENU ON WIN 11 
echo:             _____________________________________________________
echo:
echo:             [3] GET THE HEVC IMAGE EXTENSIONS FROM MICROSOFT 
echo:             _____________________________________________________
echo:
echo:             [4] LAUNCH DISK MANAGEMENT
echo:             _____________________________________________________
echo:
echo:             [5] BOOT TO BIOS
echo:             _____________________________________________________
echo:
echo:             [6] RAM CLEAN
echo:             _____________________________________________________
echo:
echo:             [7] BACK
echo:             _____________________________________________________
echo:
echo:
echo:
echo:            "Enter a menu option on the Keyboard [1,2,3,4,5,6,7] :"
choice /C:1234567 /N
set _erl=%errorlevel%

if %_erl%==7 setlocal & call :MainMenu & cls & endlocal & goto :fixes
if %_erl%==6 setlocal & call :rammap & cls & endlocal & goto :utilities
if %_erl%==5 shutdown /r /fw /t 0 & shutdown /r /fw /t 0
if %_erl%==4 diskmgmt.msc & cls & endlocal & goto :utilities
if %_erl%==3 start ms-windows-store://pdp/?ProductId=9n4wgh0z6vhq & cls & endlocal & goto :utilities
if %_erl%==2 setlocal & call :context & cls & endlocal & goto :utilities
if %_erl%==1 setlocal & call :debloater & cls & endlocal & goto :utilities

::========================================================================================================================================

:networking
cls
mode 78, 17

echo:
echo:
echo:       ______________________________________________________________
echo:
echo:             [1] CLEAR TCP/IP STACK
echo:             [2] WINSOCK RESET
echo:             [3] CLEAR DNS CACHE
echo:             [4] CLEAR ARP CACHE
echo:         __________________________________________________________
echo:
echo:             [5] BACK
echo:             [6] EXIT
echo:       ______________________________________________________________
echo:            "Enter a menu option on the Keyboard [1,2,3] :"
choice /C:123456 /N
set _erl=%errorlevel%

if %_erl%==6 exit
if %_erl%==5 goto:fixes
if %_erl%==4 setlocal & call :arp & cls & endlocal & goto :networking
if %_erl%==3 setlocal & call :dns & cls & endlocal & goto :networking
if %_erl%==2 setlocal & call :winsock & cls & endlocal & goto :networking
if %_erl%==1 setlocal & call :tcp & cls & endlocal & goto :networking


::========================================================================================================================================

:update
cls
net stop wuauserv
net start wuauserv
UsoClient.exe StartScan StartDownload StartInstall
pause
goto :fixes

::========================================================================================================================================

:arp
cls
arp -a
netsh interface IP delete arpcache
pause
goto :networking

::========================================================================================================================================

:dns
cls
ipconfig /flushdns
pause
goto :networking

::========================================================================================================================================

:winsock
cls
netsh winsock reset
ipconfig /release
pause
goto :networking

::========================================================================================================================================

:tcp
cls
netsh int ip reset
ipconfig /release
ipconfig /renew
pause
goto :networking

::========================================================================================================================================

:context
REG ADD HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32
taskkill /f /im explorer.exe 
start explorer
goto:MainMenu

::========================================================================================================================================

:debloater
powershell -noprofile -command "&{ start-process powershell -ArgumentList 'iwr -useb https://git.io/debloat|iex' -verb RunAs}"
pause
goto:MainMenu

::========================================================================================================================================

:chkdsk
chkdsk C: /r
exit

::========================================================================================================================================

:sfc
cls

sfc /scannow

echo:
echo:
echo:       ______________________________________________________________
echo:
echo:             [1] REBOOT
echo:             [2] BACK
echo:             [3] EXIT
echo:       ______________________________________________________________
echo:            "Enter a menu option on the Keyboard [1,2,3] :"
choice /C:123 /N
set _erl=%errorlevel%

if %_erl%==3 exit
if %_erl%==2 setlocal & call :fixes & cls & endlocal & goto :sfc
if %_erl%==1 shutdown /r /t 1 & shutdown /r /t 1

::========================================================================================================================================

:sfcdism
cls
mode 120, 50

sfc /scannow
dism /online /cleanup-image /checkhealth
dism /online /cleanup-image /scanhealth
dism /online /cleanup-image /restorehealth
sfc /scannow

echo:
echo:
echo:       ______________________________________________________________
echo:
echo:             [1] REBOOT
echo:             [2] BACK
echo:             [3] EXIT
echo:       ______________________________________________________________
echo:            "Enter a menu option on the Keyboard [1,2,3] :"
choice /C:123 /N
set _erl=%errorlevel%

if %_erl%==3 exit
if %_erl%==2 setlocal & call :fixes & cls & endlocal & goto :sfcdism
if %_erl%==1 shutdown /r /t 1 & shutdown /r /t 1

::========================================================================================================================================

:rammap
cls
title  PLEASE WAIT - RAWR
mode 46, 1

cd %appdata%
if exist .\ram_cleaner_rawr\RAMMap.exe (
 goto :run  
) else (
  goto :download
)

::========================================================================================================================================

:download
title  DOWNLOADING - RAWR
cd %appdata%
mkdir ram_cleaner_rawr
powershell -c "Invoke-WebRequest -Uri 'https://live.sysinternals.com/RAMMap.exe' -OutFile '%appdata%/ram_cleaner_rawr/RAMMap.exe'"
goto :run

::========================================================================================================================================

:run
title  RUNNING - RAWR
cd %appdata%/ram_cleaner_rawr
Rammap -Ew
Rammap -Em
Rammap -Es
Rammap -Et
Rammap -E0
goto :utilities

::========================================================================================================================================
