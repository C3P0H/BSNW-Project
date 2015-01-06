<#
.Synopsis
	The following script clears the temp folders.
.DESCRIPTION
	The following script clears the temp folders.   
.EXAMPLE
   .\script05.ps1
#>

<#
Author: Marvin Ecker
#>

[CmdletBinding()]
Param
(
    $tempfolders = @( "C:\Windows\Temp\*", "C:\Windows\Prefetch\*", "C:\Users\*\Appdata\Local\Temp\*")
)

Function ClearTempFolders
{
    Remove-Item $tempfolders -force -recurse
}

#entry point
ClearTempFolders