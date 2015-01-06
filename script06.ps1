<#
.Synopsis
    The following script swappes the names of two Files.
.DESCRIPTION
    The following script swappes the names of two Files.
.PARAMETER Path
    The Path of the folder
.PARAMETER PathDocument1
    The path of the first document
.PARAMETER PathDocument2
    The path of the second document
.EXAMPLE
    ./script06 -PathDocument1 C:/Dokumente/Bewerbung1.doc -PathDocument2 C:/Dokumente/Lebenslauf3.doc
#>

<#
Author: Lars Wrzeziono
#>

[CmdletBinding()]
Param
(
    [Parameter(Mandatory=$true)]
    [String]$PathDocument1,
    [String]$PathDocument2
)

Function TestPaths 
{
    if((Test-Path $PathDocument1) -eq 0)
    {
        Write-Host "$PathDocument1 does not exist"
        Exit;
    }
    if((Test-Path $PathDocument2) -eq 0)
    {
        echo "$PathDocument2 does not exist"
        Exit;
    }
}

Function SwapNames
{
    $SourcePath = Split-Path -Path $PathDocument1 -Parent
    $Rand = Get-Random 
    $PathDummyName = $SourcePath + "/" + $Rand

    Rename-Item $PathDocument1 $PathDummyName
    Rename-Item $PathDocument2 $PathDocument1
    Rename-Item $PathDummyName $PathDocument2

    Write-Host "Filenames has been swapped!"
}

#entry point
$title = "Swapping filenames"
$message = "Do you want to swap the specified filenames?"

$yes = New-Object System.Management.Automation.Host.ChoiceDescription "&Yes", `
    "Filenames will be swapped."

$no = New-Object System.Management.Automation.Host.ChoiceDescription "&No", `
    "Filenames will not be swapped"

$options = [System.Management.Automation.Host.ChoiceDescription[]]($yes, $no)

$result = $host.ui.PromptForChoice($title, $message, $options, 0) 

switch ($result)
    {
        0 
        {
            TestPaths
            SwapNames
        }
        1 
        {
            Exit
        }
    }
