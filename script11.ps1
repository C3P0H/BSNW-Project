<#
.Synopsis
   
.DESCRIPTION
   
.PARAMETER 
   
.EXAMPLE
   .\script11.ps1
#>

<#
Author: Jevgeni Ziebart
#>
Function CreatePartition
{
		Get-Disk 1 | Initialize-Disk -ErrorAction SilentlyContinue| Set-Disk -Number 1 -IsOffline $false | Set-Disk -Number 1 -IsReadOnly $false | New-Partition -DiskNumber 1 -Size 10GB -AssignDriveLetter | Format-Volume -FileSystem NTFS -Force
}
#entry point
CreatePartition