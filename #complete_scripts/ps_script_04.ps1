#-- Version History --
#Version:         01.000           
#Creation:        30.11.2014 
#Author:          Marvin Ecker
#Description:     The following script saves all processes into a .txt file.

#-- Version Changes --
#30.11.2014:      Inital commit.

#-- Code Section --

$Global:destination_file = "C:\Users\Marvin\Desktop\dienste.txt";
$Private:save_request ="Do you want to save all proccesses into a text file? (y/n)"

Function CheckFile ()
{
    if((Test-Path $Global:destinationFile) -eq 1){
        Remove-Item $Global:destinationFile -Force;
        Write-Host "File has been deleted!"
    }
}

Function SaveProcess ()
{
    Get-Process | Out-File $Global:destinationFile;
    Write-Host "Processes have been saved!"
}

if(($Private:save_request) -eq "y")
{
    CheckFile;
    SaveProcess;
}
else
{
    exit;
}

#-- End of application --