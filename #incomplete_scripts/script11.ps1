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
	for ($i=0; $i -le 2; $i++){
		Get-Disk | Where partitionstyle -eq 'raw' | Initialize-Disk -PartitionStyle GPT -PassThru |New-Partition -AssignDriveLetter -Size 2GB |Format-Volume -FileSystem NTFS
	}
}
#entry point
CreatePartition