#-- Version History --
#Version:         01.000           
#Creation:        11.12.2014 
#Author:          Lars Wrzeziono
#Description:     The following script provides a complete clear of a Network folder.

#-- Version Changes --
#30.11.2014:      Inital commit.

#-- Code Section --

$drive = Read-Host "Drive"
$pc_number = Read-Host "PC-Number"
$type = Read-Host "Type"
$room_number = Read-Host "room_number"

Join-Path $drive "$pc_number$type$room_number"
Remove-Item $drive -Force -Recurse -WhatIf
echo $path

#-- End of application --