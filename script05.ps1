<#
.Synopsis
	The following script clears all temp folders.
.DESCRIPTION
	The following script clears all temp folders.   
.EXAMPLE
   .\script05.ps1
#>

<#
Author: Marvin Ecker
#>

$tempfolders = @( "C:\Windows\Temp\*", "C:\Windows\Prefetch\*", "C:\Users\*\Appdata\Local\Temp\*")

Remove-Item $tempfolders -force -recurse
