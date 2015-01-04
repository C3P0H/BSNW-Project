<#
.Synopsis
    The following script switch the name of two Files.
.DESCRIPTION
    The following script switch the name of two Files.
.PARAMETER Path
    The Path of the folder
.PARAMETER Document_1
    The Name of the first Document
.PARAMETER Document_2
    The Name of the second Document
#>

<#
Author: Lars Wrzeziono
#>

[CmdletBinding()]
Param
(
    [Parameter(Mandatory=$true)]
    [String]$Path,
    [String]$Document_1,
    [String]$Document_2
)

$Random = Get-Random;


Function GetFilesname () 
{
    cd $Path

    if((Test-Path $Document_1) -eq 0)
    {
        echo "$Document_1 does not exist";
        pause;
        GetFilesname;
    }
    if((Test-Path $Document_2) -eq 0)
    {
        echo "$Document_2 does not exist";
        pause;
        GetFilesname;
    }
    Changename;
}

Function ChangeName()
{

    $Change = Read-Host "Would you really swap the names? [y/n]";
    
    if($Change -eq "y")
    {
        Rename-Item $Document_1 $Random;
        Rename-Item $Document_2 $Document_1;
        Rename-Item $Random $Document_2;
        echo "Names Swaped";
    }
    else
    {
       echo "Names not swaped"; 
       pause;
       exit;
    } 
}

#entry point
GetFilesname;
pause;
