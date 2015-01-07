<#
.Synopsis
    The following script provides a complete clear of a Network folder.
.DESCRIPTION
    The following script provides a complete clear of a Network folder.
.PARAMETER Drive
    Enter the Drive Letter
.PARAMETER PC-Number
    Enter the PC-Number
.PARAMETER Type
    Enter the Type
.PARAMETER Room-Number
    Enter the Room Number
.EXAMPLE script09 -Drive Z: -PC-Number PC01 -Type KA -Room-Number 121
#>

<#
Author: Lars Wrzeziono
#>

[CmdletBinding()]
Param
(
    [Parameter (Mandatory=$true)]
    [String]$Drive,
    [String]$PC_Number,
    [String]$Type,
    [String]$Room_Number
)

Function DeleteFiles ()
{
$Drive = Join-Path $Drive "$Pc_Number$Type$Room_Number\*"
Write-Host $Drive
Remove-Item  $Drive -Force -Recurse
}

#entry point
DeleteFiles;
