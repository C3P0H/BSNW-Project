<#
.Synopsis
   The following script executes a system shutdown
.DESCRIPTION
   the following script executes a system shutdown, based on a cmdlet
.PARAMETER ComputerName
   Enter the machine, which you want to shutdown
.EXAMPLE
   ps_script_01 -ComputerName Server_01
#>

<#
Author: Marvin Ecker
#>

#entry point
Stop-Computer