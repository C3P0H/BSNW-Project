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

$Global:backup_dir = "C:\Users\Marvin\Backup";
$Global:source_dir = "C:\Users\Marvin\Documents";
$Global:backup_request = Read-Host "Do you want to create a backup? (y/n)"

Function CopyItems ()
{
    Copy-Item -Recurse $Global:source_dir -Destination $Global:backup_dir -Force;
    Write-Host "Backup was sucessfull!"
}

Function CreateBackup ()
{
    if((Test-Path $Global:backup_dir) -eq 0){
        New-Item -ItemType Directory -Force -Path $Global:backup_dir;
        Write-Host "Unable to create a directory!";
        CopyItems;
    }

    if((Test-Path $Global:backup_dir) -eq 1){
        CopyItems;
    }
}

if(($Global:backup_request) -eq "y")
{
    CreateBackup;
}
else
{
    exit;
}

#-- End of application --