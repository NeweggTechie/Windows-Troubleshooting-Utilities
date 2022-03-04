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
mode 120, 30

echo:
echo:       ______________________________________________________________
echo:
echo:
echo:             [1] SFC AND DISM
echo:             [2] SFC ONLY
echo:             [3] CHKDSK      
echo:
echo:             _____________________________________________________
echo:
echo:                                                                  
echo:             [4] DEBLOATER
echo:             [5] RESTORE WIN 10 DESKTOP RIGHT CLICK MENU ON WIN 11
echo:             [6] GET THE HEVC IMAGE EXTENSIONS FROM MICROSOFT
echo:
echo:             _____________________________________________________  
echo:
echo:
echo:             [7] LAUNCH DISK MANAGEMENT
echo:             [8] NETWORKING FIXES
echo:             [9] BOOT TO BIOS
echo:
echo:       ______________________________________________________________
echo:
echo:
echo:
echo:            "Enter a menu option on the Keyboard [1,2,3,4,5,6,7,8,9] :"
choice /C:123456789 /N
set _erl=%errorlevel%

if %_erl%==9 shutdown /r /fw /t 0
if %_erl%==8 setlocal & call :networking & cls & endlocal & goto :MainMenu
if %_erl%==7 diskmgmt.msc & cls & endlocal & goto :MainMenu
if %_erl%==6 start ms-windows-store://pdp/?ProductId=9n4wgh0z6vhq
if %_erl%==5 setlocal & call :context & cls & endlocal & goto :MainMenu
if %_erl%==4 setlocal & call :debloater & cls & endlocal & goto :MainMenu
if %_erl%==3 setlocal & call :chkdsk & cls & endlocal & goto :MainMenu
if %_erl%==2 setlocal & call :sfc & cls & endlocal & goto :MainMenu
if %_erl%==1 setlocal & call :sfcdism & cls & endlocal & goto :MainMenu
goto :MainMenu

::========================================================================================================================================

:networking
cls

echo:
echo:
echo:       ______________________________________________________________
echo:
echo:             [1] CLEAR TCP/IP STACK
echo:             [2] WINSOCK RESET
echo:             [3] CLEAR DNS CACHE
echo:             [4] CLEAR ARP CACHE
echo:             [5] RESTART WINDOWS UPDATE
echo:         __________________________________________________________
echo:
echo:             [6] RETURN TO MENU
echo:             [7] EXIT
echo:       ______________________________________________________________
echo:            "Enter a menu option on the Keyboard [1,2,3] :"
choice /C:1234567 /N
set _erl=%errorlevel%

if %_erl%==7 exit
if %_erl%==6 goto:MainMenu
if %_erl%==5 setlocal & call :update & cls & endlocal & goto :networking
if %_erl%==4 setlocal & call :arp & cls & endlocal & goto :networking
if %_erl%==3 setlocal & call :dns & cls & endlocal & goto :networking
if %_erl%==2 setlocal & call :winsock & cls & endlocal & goto :networking
if %_erl%==1 setlocal & call :tcp & cls & endlocal & goto :networking


::========================================================================================================================================

:update
net stop wuauserv
net start wuauserv
UsoClient.exe StartScan StartDownload StartInstall
ping 127.0.0.1 -n 6 > nul
goto :networking

::========================================================================================================================================

:arp
arp -a
netsh interface IP delete arpcache
ping 127.0.0.1 -n 6 > nul
goto :networking

::========================================================================================================================================

:dns
ipconfig /flushdns
ping 127.0.0.1 -n 6 > nul
goto :networking

::========================================================================================================================================

:winsock
netsh winsock reset
ipconfig /release
ping 127.0.0.1 -n 6 > nul
goto :networking

::========================================================================================================================================

:tcp
netsh int ip reset
ipconfig /release
ipconfig /renew
ping 127.0.0.1 -n 6 > nul
goto :networking

::========================================================================================================================================

:context
REG ADD HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32
exit

::========================================================================================================================================

:debloater
powershell -noprofile -command "&{ start-process powershell -ArgumentList 'iwr -useb https://git.io/debloat|iex' -verb RunAs}"
taskkill /f /im explorer.exe & start explorer
exit

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
echo:             [2] RETURN TO MENU
echo:             [3] EXIT
echo:       ______________________________________________________________
echo:            "Enter a menu option on the Keyboard [1,2,3] :"
choice /C:123 /N
set _erl=%errorlevel%

if %_erl%==3 exit
if %_erl%==2 goto:MainMenu
if %_erl%==1 shutdown /r /t 1

::========================================================================================================================================

:sfcdism
cls

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
echo:             [2] RETURN TO MENU
echo:             [3] EXIT
echo:       ______________________________________________________________
echo:            "Enter a menu option on the Keyboard [1,2,3] :"
choice /C:123 /N
set _erl=%errorlevel%

if %_erl%==3 exit
if %_erl%==2 goto:MainMenu
if %_erl%==1 shutdown /r /t 1
::========================================================================================================================================
