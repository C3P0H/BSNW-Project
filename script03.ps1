<#
.Synopsis
   the following script creates a backup
.DESCRIPTION
   the following script provides a mirroring function for directorys
.PARAMETER SourcePath
   Enter the path to the source directory
.PARAMETER BackupPath
   Enter the path to the backup directory
.EXAMPLE
   script03.ps1 -SourcePath C:\Users\Fred\Desktop\Documents -BackupPath C:\Users\Fred\Desktop\Backup
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
               Copy-Item $file.FullName -Destination $BackupPath
        }
    }
}

Function CheckSourceFiles
{
    $backupFiles = Get-ChildItem -Path $BackupPath -Recurse
    
    foreach($backupFile in $backupFiles)
    {
        if(!(Test-Path -Path ($SourcePath + "\" + $backupFile))){
            Remove-Item -Path ($BackupPath + "\" + $backupFile) -ErrorAction Continue
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
CheckSourceFiles