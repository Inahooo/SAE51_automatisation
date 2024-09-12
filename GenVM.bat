@echo off
set path="c:\Program Files\Oracle\VirtualBox\VBoxManage.exe"
set sys="C:\Windows\System32"
set MachineName=%2%
set DD="65536"
set RAM="4096"
set CPU="2"
cls
title VBoxManagement

if "%1"=="" goto getError_code_1

if "%1"=="-L" goto getList

if "%2"=="" goto getError_code_2

if "%1"=="-N" (
if "%2"=="" (
goto getError_code_2
)
if not "%2%"=="" ( 
goto getChecked
))

if "%1"=="-S" (
if "%2"=="" (
goto getError_code_2
)
if not "%2%"=="" ( 
goto getDelete
))

if "%1"=="-D" (
if "%2"=="" (
goto getError_code_2
)
if not "%2%"=="" ( 
goto getStart
))

if "%1"=="-A" (
if "%2"=="" (
goto getError_code_2
)
if not "%2%"=="" ( 
goto getStop
))

goto getError_code_0


:getError_code_1
cls
echo Errorlevel: %errorlevel%
echo.
echo GenVM_3.bat {[-D] [-L] [-S] [-D] [-A]} {Machine Name}
echo.
echo -D To start a specific virtual machine [require a second argument]
echo -A To stop a specific virtual machine [require a second argument]
echo -S To delete a specific virtual machine [require a second argument]
echo -N To create a specific virtual machine [require a second argument]
echo -L To give informations on overall virtual machine and/or a single virtual machine [may require a second argument]
exit /b 2


:getError_code_2
cls
echo Errorlevel: %errorlevel%
echo No second argument
echo Example : GenVM_3.bat %1% ExampleName
exit /b 3


:getError_code_0
echo Errorlevel: %errorlevel%
exit /b 1


:getChecked
echo ==================Checking process==================
%path% list vms > "C:\Users\admin\VirtualBox VMs\list.txt"
%sys%\find "%MachineName%" "C:\Users\admin\VirtualBox VMs\list.txt" && (
echo "VM was found."
call :getDelete
call :getCreate
goto getFinish
) || (
echo "VM was NOT found."
call :getCreate
)
exit /b 0


:getDelete
echo ==================Deleting process==================  
echo Deleting VM %MachineName%...
%path% unregistervm "%MachineName%" --delete
del "C:\Users\admin\.VirtualBox\TFTP\%MachineName%.pxe"
exit /b 0


:getList
cls
echo ==================Liste==================  
%path% list vms
if not "%2"=="" (
echo Info for %MachineName%
%path% getextradata %MachineName%
)
exit /b 0


:getCreate
echo ==================Creating process================== 
%path% createvm --name %MachineName% --register
echo Registering OS Type...
%path% modifyvm %MachineName% --ostype Ubuntu_64
echo Setting boot order...
%path% modifyvm %MachineName% --boot1 net --boot2 disk --boot3 none --boot4 none --nicbootprio1 1
echo Enabling audio...
%path% modifyvm %MachineName% --audio dsound --audiocontroller ac97
echo Setting machine specs...
%path% modifyvm %MachineName% --memory %RAM% --vram "512" --cpus %CPU% --acpi on --ioapic on --nic1 nat
echo Creating Disk File...
%path% createhd --filename "C:\Users\admin\VirtualBox VMs\%MachineName%\%MachineName%_DISK.vdi" --size %DD%
echo Setting up the Disks...
%path% storagectl %MachineName% --name "SATA Controller" --add sata --controller IntelAhci
%path% storageattach %MachineName% --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium "C:\Users\admin\VirtualBox VMs\%MachineName%\%MachineName%_DISK.vdi"
%path% storagectl %MachineName% --name "IDE Controller" --add ide --controller PIIX4
copy "C:\Users\admin\.VirtualBox\TFTP\base.pxe" "C:\Users\admin\.VirtualBox\TFTP\%MachineName%.pxe"
echo Setting extra data
%path% setextradata %MachineName% installdate %date%
echo %MachineName% has been succesfully created.
exit /b 0


:getStart
echo Starting %MachineName%
%path% startvm %MachineName%
exit /b 0


:getStop
echo Stoping %MachineName%
%path% controlvm %MachineName% poweroff
echo %MachineName% has been succesfully stopped.
exit /b 0
