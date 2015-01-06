<#
.Synopsis
   the following script creates a backup of an USB-Flashdrive
.DESCRIPTION
   the following script creates a backup of an USB-Flashdrive
.PARAMETER UsbDriveletter
   Enter the driveletter of an USB-Flashdrive
.PARAMETER BackupPath
   Enter the path of your flashdrive you want to backup your USB-Flashdrive to
.EXAMPLE
   script08.ps1 -UsbDriverletter D:\ -BackupPath C:\Backup -DeleteFiles $false
#>

<#
Author: Jevgeni Ziebart
#>

[CmdletBinding()]
Param
(
    [Parameter(Mandatory=$true)]
    [String]$UsbDriveletter,
    [String]$BackupPath
)


Function CheckParameters
{
        if(!(Test-Path -Path $UsbDriveletter)){
            Write-Host "UsbDriveletter does not exists"
            Exit
        }
        if(!(Test-Path -Path $BackupPath)){
            Write-Host "BackupDirectory does not exists"
            New-Item -Itemtype directory -Path BackupPath -Confirm
        }
}

Function CopyFiles
{
        Copy-Item $UsbDriveletter* $BackupPath -Recurse -Force
}


Function DeleteFiles
{
        Remove-Item -Recurse -path $UsbDriveletter* -Confirm
}

#entry point
CheckParameters
CopyFiles
DeleteFiles