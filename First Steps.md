- [ ] Change all passwords
- [ ] Update all devices
- [ ] Install logger (if applicable)
- [ ] Look for backdoors

# Windows
- [ ] Install Procmon
- [ ] Startup Applications in Task Manager
- [ ] Sticky Keys
- [ ] Check these keys
```
HKEY_CU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run
HKEY_CU\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce
HKEY_LM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run
HKEY_LM\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce
```
- [ ] [NetSH](https://www.ired.team/offensive-security/persistence/t1128-netsh-helper-dll)
	- [ ] `Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NetSh`
- [ ] [Windows Logon Helper](https://attack.mitre.org/techniques/T1547/004/)
	- [ ] `HKCU\Software\Microsoft\Windows NT\CurrentVersion\Winlogon\Userinit`
	- [ ] `HKCU\Software\Microsoft\Windows NT\CurrentVersion\Winlogon\Notify`
	- [ ] `HKCU\Software\Microsoft\Windows NT\CurrentVersion\Winlogon\shell`
- [ ] [Default File Extension Hijacking](https://www.ired.team/offensive-security/persistence/hijacking-default-file-extension)
	- [ ] Might want to scan for weird extension scripts
	- [ ] `Computer\HKEY_CLASSES_ROOT\<file type>`
```powershell
$ExtensionKeys = (Get-ItemProperty Registry::HKEY_CLASSES_ROOT\*\shell\open\command)
$ExtensionKeys | ? { $_."(default)" } | select psparentpath, "(default)"
```
- [ ] Evil Service
	- [ ] `HKLM\SYSTEM\CurrentControlSet\services\<Evil Service>`
	- [ ] Registered under `HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Svchost` in `DcomLaunch`
	- [ ] Look for services that aren't under `C:\Windows\System32`
```powershell
$ServiceKeys = (Get-ItemProperty hklm:\SYSTEM\ControlSet001\Services\*\Parameters)
$ServiceKeys | ? { $_.servicedll } | select psparentpath, servicedll
```
- [ ] Screen Saver
```powershell
(Get-ItemProperty 'Registry::HKEY_CURRENT_USER\Control Panel\Desktop')
```

# Linux
- [ ] Cron jobs
- [ ] SSH Keys
- [ ] Reverse shell
	- [ ] Check open ports

## Notes
- Ensure that only admins can create net users
- DON'T EVER USER FILE SHORTCUTS ON WINDOWS BC THAT'S HOW WE GET PWNED