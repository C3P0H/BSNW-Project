<#
.Synopsis
   the following script creates a backup
.DESCRIPTION
   the following script creates a backup
.PARAMETER SourcePath
   Enter the path of the source directory
.PARAMETER BackupPath
   Enter the path of the backup directory
.EXAMPLE
   script02.ps1 -SourcePath C:\Users\Fred\Desktop -BackupPath C:\Backup
#>

<#
Author: Marvin Ecker
#>


[CmdletBinding()]
Param
(
    [Parameter(Mandatory=$true)]
    [String]$SourcePath,
    [String]$BackupPath
)

$files = Get-ChildItem -Path $SourcePath -Recurse
$attribute = [io.fileattributes]::archive

Function CopyArchiveFiles
{
    foreach($file in $files)
    {
        If((Get-ItemProperty -Path $file.FullName).Attributes -band $attribute){
               Copy-Item $file.FullName -Destination $BackupPath -Confirm
        }
    }
}

Function RemoveArchiveBit
{
    Foreach($file in $files)
    {
        If((Get-ItemProperty -Path $file.fullname).attributes -band $attribute){
            Set-ItemProperty -Path $file.fullname -Name attributes -Value ((Get-ItemProperty $file.fullname).attributes -BXOR $attribute)
        }
    }
}

Function CheckParameters
{
    if (! (Test-Path -Path $SourcePath)){
        Write-Host "SourceDirectory does not exists"
    }

    if (! (Test-Path -Path $BackupPath)){
        Write-Host "BackupDirectory does not exists"
        New-Item -ItemType directory -Path $BackupPath -Confirm
    }
}

#entry point
CheckParameters
CopyArchiveFiles
RemoveArchiveBit