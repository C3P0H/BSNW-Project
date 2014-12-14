#-- Version History --
#Version:         01.000           
#Creation:        11.12.2014 
#Author:          Lars Wrzeziono
#Description:     The following script provides a complete clear of a Network folder.

#-- Version Changes --
#30.11.2014:      Inital commit.

#-- Code Section --

# Getting the Folders and delete all the Files
Function DeleteFiles ()
{
$Global:Drive = Read-Host "Drive"
$Global:Pc_number = Read-Host "PC-Number"
$Global:Type = Read-Host "Type"
$Globa:Room_number = Read-Host "room_number"

$Global:Drive = Join-Path $Global:Drive "$Global:Pc_number$Global:Type$Global:Room_number"
cd $Global:Drive
Remove-Item $Global:Drive -Force -Recurse -WhatIf
}
DeleteFiles;

#-- End of application --