#-- Version History --
#Version:         01.000           
#Creation:        30.11.2014 
#Author:          Marvin Ecker
#Description:     The following script saves all processes into a .txt file.

#-- Version Changes --
#30.11.2014:      Inital commit.

#-- Code Section --

$env:username;

$Global:destination_file = "C:\Users\" + $env:username + "\Desktop\Dienste.txt";
$Global:save_request = Read-Host "Do you want to save all services into a text file? (y/n)";

#The following function checks the existence of an old file and deletes it
Function delete_file ()
{
    if((Test-Path $Global:destination_file) -eq 0){
       echo "No old file has been found!";
    }
    
    if((Test-Path $Global:destination_file) -eq 1){
        Remove-Item $Global:destination_file -Force;
        echo "Old file has been deleted!";
    }
}

#The following function saves all currently running services and saves them into a .txt file
Function save_services ()
{
    Get-Service | Out-File $Global:destination_file;
    echo "Services have been saved!";
}

#Standard user query
if(($Global:save_request) -eq "y"){
    delete_file;
    save_process;
}
else{
    exit;
}

#-- End of application --