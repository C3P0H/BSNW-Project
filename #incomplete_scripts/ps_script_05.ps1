#-- Version History --
#Version:         01.000           
#Creation:        01.12.2014 
#Author:          Marvin Ecker
#Description:     The following script clears the temp folders.

#-- Version Changes --
#01.12.2014:      initial commit

#-- Code Section --

#ToDo
#Script should be able to interact in a network.

$tempfolders = @( "C:\Windows\Temp\*", "C:\Windows\Prefetch\*", "C:\Users\*\Appdata\Local\Temp\*");
$clear_request = Read-Host "Do you want to clear the temp folders? y/n";

if(($clear_request) -eq "y")
{
    foreach($item in $tempfolders)
    {
            Remove-Item $item -force -recurse;
    }
}
else
{
    exit;
}
#-- End of application --