<#
.Synopsis
   
.DESCRIPTION
   
.PARAMETER 
   
.EXAMPLE
   .\script11.ps1
#>

<#
Author: Jevgeni Ziebart
#>
Function CreatePartition
{
    
    Get-Disk | Where partitionstyle -eq 'raw' | Initialize-Disk -PartitionStyle GPT -PassThru |New-Partition -AssignDriveLetter -Size 10GB |Format-Volume -FileSystem NTFS
}
#entry point
CreatePartition