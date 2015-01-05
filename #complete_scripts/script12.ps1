<#
.Synopsis
   the following script creates a backup of an automatically selected USB-Flashdrive
.DESCRIPTION
   the following script creates a backup of an automatically selected USB-Flashdrive
.PARAMETER BackupPath
   Enter the path of your flashdrive you want to backup your USB-Flashdrive to
.PARAMETER DeleteFiles
   
.EXAMPLE
   script12.ps1 -BackupPath C:\Backup -DeleteFiles -false
#>

<#
Author: Jevgeni Ziebart
#>

[CmdletBinding()]
Param
(
    [Parameter(Mandatory=$true)]
    [String]$BackupPath,
    [Boolean]$DeleteFiles
)
 
Function SelectUsbFlashDrive
{
    gwmi win32_diskdrive | ?{$_.interfacetype -eq "USB"} | %{gwmi -Query "ASSOCIATORS OF {Win32_DiskDrive.DeviceID=`"$($_.DeviceID.replace('\','\\'))`"} WHERE AssocClass = Win32_DiskDriveToDiskPartition"} |  %{gwmi -Query "ASSOCIATORS OF {Win32_DiskPartition.DeviceID=`"$($_.DeviceID)`"} WHERE AssocClass = Win32_LogicalDiskToPartition"} | %{$_.deviceid} -OutVariable Global:UsbDriveletter
}

Function CheckParameters
{
    if(!(Test-Path -Path $UsbDriveletter)){
        Write-Host "UsbDriveletter does not exists"
        New-Item -Itemtype directory -Path BackupPath -Confirm
    }
    if(!(Test-Path -Path $BackupPath)){
        Write-Host "BackupDirectory does not exists"
        New-Item -Itemtype directory -Path BackupPath -Confirm
    }
}

Function CopyFiles
{
    Copy-Item $UsbDriveletter\* $BackupPath -Recurse -Force
}


Function DeleteFiles
{
    if(($DeleteFiles)-eq $true){
        Remove-Item -Recurse -path $UsbDriveletter\*
    }
}

#entry point
SelectUsbFlashDrive
CheckParameters
CopyFiles
DeleteFiles