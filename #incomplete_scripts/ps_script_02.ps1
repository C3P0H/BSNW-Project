#-- Version History --
#Version:         01.000           
#Creation:        30.11.2014 
#Author:          Marvin Ecker
#Description:     The following script provides a function to backup directorys.

#-- Version Changes --
#30.11.2014:      Inital commit.

#-- Code Section --

#-- ToDo --
#Check ArchiveBit

$Global:backupDir = "C:/Users/Marvin/Backup";
$Global:sourceDir = "C:/Users/Marvin/Documents";

Function CopyItems ()
{
        Copy-Item -Recurse $Global:sourceDir -Destination $Global:backupDir -Force;
        Write-Host "Backup was sucessfull!"
}

Function CreateBackup ()
{
    if((Test-Path $Global:backupDir) -eq 0){
        New-Item -ItemType Directory -Force -Path $Global:backupDir -ErrorAction Stop;
        CopyItems;
    }

    if((Test-Path $Global:backupDir) -eq 1){
        CopyItems;
    }
}

CreateBackup;

#-- End of application --