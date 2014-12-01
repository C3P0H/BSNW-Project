#-- Version History --
#Version:         01.000           
#Creation:        01.12.2014 
#Author:          Jevgeni Ziebart
#Description:     The following script provides a complete system shutdown.

#-- Version Changes --
#01.12.2014:      Done some fancy shit(itsabeta).

#-- Code Section --

#ToDo
#replace that workaround sparta usbDir function with something "more suitable" 
#(i dont need you to see that its shit marvin)
#removing double output after successfull copying


$Global:hddDir = "c:\usb";
$Global:usbDir = "";
$Global:userUsbDir = "d";


Function CopyFiles()
{
    Copy-Item $Global:usbDir $Global:hddDir -Recurse -Force;
    echo "Your files were successfully copied to $hddDir";
    DeleteFiles;
}

Function CheckDirs()
{
    if((Test-Path -Path $Global:hddDir) -eq 0)
    {
    New-Item $Global:hddDir -type directory;
    Copyfiles;
    }

    if((Test-Path -Path $Global:hddDir) -eq 1)
    {
    CopyFiles;
    }
}

Function DeleteFiles()
{
    $delete = Read-Host "Do you want to delete any file on your flashdrive? y/n";
    if(($delete) -eq "n")
    {
    exit;
    }

    if(($delete) -eq "y")
    {
    Remove-Item -Recurse -path $Global:usbDir;
    echo "Your files were deleted";
    }
}

Function Sparta()
{
    $Global:userUsbDir= Read-Host "What driveletter is your flashdrive";
    $Global:usbDir=$Global:userUsbDir+":\*";
    CheckDirs;
}
Sparta;

#-- End of application --