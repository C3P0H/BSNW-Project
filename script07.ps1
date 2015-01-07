<#
.Synopsis
    the following script creats multiple Networkdrives
.DESCRIPTION
    the following script creats multiple Networkdrives
.PARAMETER ServerPath
    Enter the Path of the Server
.EXAMPLE
    script07 -ServerPath 192.168.0.102
#>
<#
Author: Lars Wrzeziono
#>

[CmdletBinding()]
Param
(
    [Parameter(Mandatory=$true)]
    [String]$ServerPath = ""
)

$User = $env:USERNAME
$UserDrivePath = ""
$PublicDrivePath = ""
$SecretDrivePath = ""
$CopyPath = ""
$GroupMembers = ""

$ServerPath = "//$Serverpath"

Function UserDrive()
{
    $UserDrivePath = Join-Path $ServerPath $User
    New-PSDrive -Persist -Name H -PSProvider FileSystem -Root $UserDrivePath -Scope Global
}

Function PublicDrive()
{
    $PublicDrivePath = Join-Path $ServerPath "Public"
    New-PSDrive -Persist -Name P -PSProvider FileSystem -Root $PublicDrivePath -Scope Global
}

Function SecretDrive()
{
    $GroupMembers = net localgroup administratoren
    for($i=0;$i -lt $GroupMembers.Length;$i++)
    {
        $SecretDrivePath = Join-Path $ServerPath "Geheim"
        if($GroupMembers.Item($i) -eq $User)
        {
            New-PSDrive -Persist -Name G -PSProvider FileSystem -Root $SecretDrivePath -Scope Global
        }
    }
}

Function CopyFile()
{
    $CopyPath = Join-Path $ServerPath "Geheim\aufgaben.txt"
    Copy $CopyPath C:\Users\$User\Desktop
}

Function UserWelcome()
{
    Clear-Host
    Write-Host "Hallo,$User"
    Get-date -Format F
    pause
}

#entry point
UserDrive
PublicDrive
SecretDrive
CopyFile
UserWelcome
