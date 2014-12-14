#-- Version History --
#Version:         01.000           
#Creation:        30.11.2014 
#Author:          Marvin Ecker
#Description:     The following script provides a complete system shutdown.

#-- Version Changes --
#30.11.2014:      Inital commit.

#-- Code Section --

$shutdown_request = Read-Host "Do you want to shutdown the PC? y/n";

#Standard user query
if(($shutdown_request) -eq "y")
{
    shutdown.exe -s -t 0;
}
else
{
    exit;
}
#-- End of application --