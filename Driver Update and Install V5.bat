 @echo off

:MainMenu

cls
title  WINDOWS DRIVER UPDATE AND INSTALL - RAWR
mode 80, 25

echo:
echo:       ______________________________________________________________
echo:
echo:
echo:             [1] CHIPSET
echo:
echo:             [2] WiFi
echo:
echo:             [3] ETHERNET
echo:    
echo:             [4] GPU
echo:
echo:             [5] AUDIO
echo:
echo:             [6] SSD FIRMWARE UPDATE GUIDE
echo:
echo:             [7] RESTART WINDOWS UPDATE TO LOOK FOR NEW DRIVERS
echo:
echo:             [8] EXIT
echo:
echo:       ______________________________________________________________
echo:
echo:
echo:
echo:            "Enter a menu option on the Keyboard [1,2,3,4,5,6,7,8] :"
choice /C:12345678 /N
set _erl=%errorlevel%

if %_erl%==8 exit
if %_erl%==7 setlocal & call :update & cls & endlocal & goto :MainMenu
if %_erl%==6 start https://github.com/NeweggTechie/Update-Drivers-Firmware/wiki/Firmware & cls & endlocal & goto :MainMenu
if %_erl%==5 setlocal & call :audio & cls & endlocal & goto :MainMenu
if %_erl%==4 setlocal & call :gpu & cls & endlocal & goto :MainMenu
if %_erl%==3 setlocal & call :ethernet & cls & endlocal & goto :MainMenu
if %_erl%==2 setlocal & call :wifi & cls & endlocal & goto :MainMenu
if %_erl%==1 setlocal & call :chipset & cls & endlocal & goto :MainMenu
goto :MainMenu

::========================================================================================================================================

:easteregg
cls
mode 80, 15
echo:
echo:
echo:
echo:
echo:	Congratulations.
echo:
echo:
echo:	If you're reading this, it means you discovered my secret easter egg.
echo:	Uhhh dunno what goes here so uhhh.... I like cats.
echo: Anyway redirecting you to the main page again. Good bye.
ping 127.0.0.1 -n 6 > nul
ping 127.0.0.1 -n 6 > nul
goto :gpu

::========================================================================================================================================

:update
cls
net stop wuauserv
net start wuauserv
UsoClient.exe StartScan StartDownload StartInstall
ping 127.0.0.1 -n 6 > nul
goto :MainMenu

::========================================================================================================================================

:audio
cls
mode 80, 15
echo:
echo:             REALTEK AUDIO
echo:             Download from your specific Motherboard Support page 
echo:             or support page for the prebuilt since realtek servers 
echo:             have awful download speed.
echo:	      ______________________________________________________________
echo:
echo:             [1] RETURN TO MENU
echo:             [2] EXIT
echo:       ______________________________________________________________
echo:            "Enter a menu option on the Keyboard [1,2] :"
choice /C:12 /N
set _erl=%errorlevel%

if %_erl%==2 exit
if %_erl%==1 goto:MainMenu

::========================================================================================================================================

:gpu
cls
mode 80, 30
echo:
echo:             FOR AMD
echo:             Press 1 and download the Auto-Detect and Install Updates 
echo:             Utility and get your drivers.
echo:
echo:             FOR NVIDIA
echo:             Press 2 and download the Auto-Detect and Install Updates Utility 
echo:             and get your drivers
echo:             
echo:             FOR INTEL
echo:             Press 3 and download the driver and support assistant and 
echo:             follow on screen prompts
echo:             
echo:             ALTERNATE INSTALL INSTRUCTIONS
echo:             Press 4 to go to my github page with direct install instructions
echo:             without the need of any auto install programs           
echo:             
echo:	      ______________________________________________________________
echo:
echo:             [1] AMD GPU DRIVERS
echo:             [2] NVIDIA GPU DRIVERS
echo:             [3] INTEL GPU DRIVERS
echo:             [4] ALTERNATE INSTALL METHODS
echo:             [5] RETURN TO MENU
echo:             [6] EXIT
echo:       ______________________________________________________________
echo:            "Enter a menu option on the Keyboard [1,2,3,4,5,6,7,8] :"
choice /C:12345678 /N
set _erl=%errorlevel%

if %_erl%==8 goto:easteregg & cls & endlocal & goto :gpu
if %_erl%==7 goto:gpu & cls & endlocal & goto :gpu
if %_erl%==6 exit
if %_erl%==5 goto:MainMenu & cls & endlocal & goto:MainMenu
if %_erl%==4 start https://github.com/NeweggTechie/Update-Drivers-Firmware/wiki/Drivers#gpu-drivers & cls & endlocal & goto :gpu
if %_erl%==3 start https://www.intel.com/content/www/us/en/support/detect.html & cls & endlocal & goto :gpu
if %_erl%==2 start https://www.nvidia.com/en-us/geforce/drivers/ & cls & endlocal & goto :gpu
if %_erl%==1 start https://www.amd.com/en/support & cls & endlocal & goto :gpu

::========================================================================================================================================

:ethernet
cls
echo:
echo:             FOR REALTEK
echo:             Download from your specific Motherboard Support page 
echo:             or support page for the prebuilt since realtek servers 
echo:             have awful download speed.
echo:
echo:             FOR INTEL
echo:             Press 1 and download the driver and support assistant and 
echo:             follow on screen prompts
echo:             
echo:             ALTERNATE INSTALL INSTRUCTIONS
echo:             Press 2 to go to my github page with direct install instructions
echo:             without the need of any auto install programs           
echo:             
echo:	      ______________________________________________________________
echo:
echo:             [1] INTEL ETHERNET DRIVERS
echo:             [2] ALTERNATE INSTALL METHODS
echo:             [3] RETURN TO MENU
echo:             [4] EXIT
echo:       ______________________________________________________________
echo:            "Enter a menu option on the Keyboard [1,2,3,4,5] :"
choice /C:12345 /N
set _erl=%errorlevel%

if %_erl%==4 exit
if %_erl%==3 goto:MainMenu & cls & endlocal & goto :ethernet
if %_erl%==2 start https://github.com/NeweggTechie/Update-Drivers-Firmware/wiki/Drivers#ethernet-drivers & cls & endlocal & goto :ethernet
if %_erl%==1 start https://www.intel.com/content/www/us/en/support/detect.html & cls & endlocal & goto :ethernet

::========================================================================================================================================

:wifi
cls
mode 80, 25
echo:
echo:             FOR REALTEK
echo:             Download from your specific Motherboard Support page 
echo:             or support page for the prebuilt since realtek servers 
echo:             have awful download speed.
echo:
echo:             FOR QUALCOMM
echo:             Download from product page since qualcomm doesnt give  
echo:             driver downloads on their website.
echo:             
echo:             FOR INTEL
echo:             Press 1 and download the driver and support assistant and 
echo:             follow on screen prompts
echo:             
echo:             ALTERNATE INSTALL INSTRUCTIONS
echo:             Press 4 to go to my github page with direct install instructions
echo:             without the need of any auto install programs           
echo:             
echo:	      ______________________________________________________________
echo:
echo:             [1] INTEL WiFi DRIVERS
echo:             [2] ALTERNATE INSTALL METHODS
echo:             [3] RETURN TO MENU
echo:             [4] EXIT
echo:       ______________________________________________________________
echo:            "Enter a menu option on the Keyboard [1,2,3,4] :"
choice /C:1234 /N
set _erl=%errorlevel%

if %_erl%==4 exit
if %_erl%==3 goto:MainMenu & cls & endlocal & goto :wifi
if %_erl%==2 start https://github.com/NeweggTechie/Update-Drivers-Firmware/wiki/Drivers#wifi-drivers & cls & endlocal & goto :wifi
if %_erl%==1 start https://www.intel.com/content/www/us/en/support/detect.html & cls & endlocal & goto :wifi

::========================================================================================================================================

:chipset
cls
mode 80, 25
echo:
echo:             FOR INTEL
echo:             Press 1 and download the installer and run it
echo:
echo:             FOR AMD
echo:             Press 2 and download the Auto-Detect and Install Updates 
echo:             Utility and get your drivers.
echo:             
echo:             ALTERNATE INSTALL INSTRUCTIONS
echo:             Press 3 to go to my github page with direct install instructions
echo:             without the need of any auto install programs           
echo:             
echo:	      ______________________________________________________________
echo:
echo:             [1] INTEL CHIPSET DRIVERS
echo:             [2] AMD CHIPSET DRIVERS
echo:             [3] ALTERNATE INSTALL METHODS
echo:             [4] RETURN TO MENU
echo:             [5] EXIT
echo:       ______________________________________________________________
echo:            "Enter a menu option on the Keyboard [1,2,3,4,5] :"
choice /C:12345 /N
set _erl=%errorlevel%

if %_erl%==5 exit
if %_erl%==4 goto:MainMenu & cls & endlocal & goto :chipset
if %_erl%==3 start https://github.com/NeweggTechie/Update-Drivers-Firmware/wiki/Drivers#chipset-drivers & cls & endlocal & goto :chipset
if %_erl%==2 start https://www.amd.com/en/support & cls & endlocal & goto :chipset
if %_erl%==1 start https://www.intel.com/content/www/us/en/download/19347/30553/chipset-inf-utility.html & cls & endlocal & goto :chipset

::========================================================================================================================================
