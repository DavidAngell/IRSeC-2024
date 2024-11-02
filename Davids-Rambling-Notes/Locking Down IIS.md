- Execute the following command to ensure no virtual directories are mapped to the system drive
```powershell
Get-Website | Format-List Name, PhysicalPath
```
- Ensure all host headers are configured
```powershell
Get-WebBinding -Port * | Format-List bindingInformation
```
- Ensure directory browsing is disabled
```powershell
Get-WebConfigurationProperty -Filter system.webserver/directorybrowse -PSPath iis:\ -Name Enabled | select Value
```
