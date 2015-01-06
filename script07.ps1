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

$User = $env:USERNAME;
$UserDrivePath = "";
$PublicDrivePath = "";
$SecretDrivePath = "";
$CopyPath = "";
$Password = "1234567890";
$GroupMembers = "";

$ServerPath = "//$Serverpath";

Function UserDrive
{
    $UserDrivePath = Join-Path $ServerPath $User;
    net use H: $UserDrivePath /user:$User $Password;
}

Function PublicDrive
{
    $PublicDrivePath = Join-Path $ServerPath "public";
    net use P: $PublicDrivePath /user:$User $Password;
}

Function SecretDrive 
{
    $GroupMembers = net localgroup administratoren;
    for($i=0;$i -lt $GroupMembers.Length;$i++)
    {
        $SecretDrivePath = Join-Path $ServerPath "Geheim";
        if($GroupMembers.Item($i) -eq $User)
        {
            net use G: $SecretDrivePath /user:$User $Password;
        }
    }
}

Function CopyFile
{
    $CopyPath = Join-Path $ServerPath "Geheim\aufgaben.txt";
    Copy $CopyPath C:\Users\$User\Desktop;
}

Function UserWelcome
{
    cls;
    echo "Hallo,$User";
    date;
    pause;
}

#entry point
UserDrive;
PublicDrive;
SecretDrive;
UserWelcome;
CopyFile;