#-- Version History --
#Version:         01.000           
#Creation:        01.12.2014 
#Author:          Jevgeni Ziebart
#Description:     The following script copies all files from a USB-Flashdrive to your harddisk.

#-- Version Changes --
#01.12.2014:      initial commit

#-- Code Section --

#ToDo
#Adding support for 2 or more USB-Flashdrives


$Global:usbDir;
$Global:hddDir;

Function ClearVariables()
{
    $Global:usbDir = "";
    $Global:hddDir = "";
    $dLetter = "";
}

Function CopyFiles()
{
    Copy-Item $Global:usbDir $Global:hddDir -Recurse -Force;
    Write-Host "Your files were successfully copied to $hddDir";
    DeleteFiles;
}

Function CheckDirs()
{
    $Global:hddDir = Read-Host "Where do you want to save your flashdrive files?";
    if((Test-Path -Path $Global:hddDir) -eq 0)
    {
        New-Item $Global:hddDir -type directory;
        Copyfiles;
    }
    else
    {
        CopyFiles;
    }
}

Function DeleteFiles()
{
    $delete = Read-Host "Do you want to delete any file on your flashdrive? y/n";
    if(($delete) -eq "y")
    {
        Remove-Item -Recurse -path $Global:usbDir;
        Write-Host "Your files were deleted";
    }
    else
    {
        ClearVariables;
        Exit;
    }
}

Function AutoSelect()
{   
    try
    {
        $dLetter = gwmi win32_diskdrive | ?{$_.interfacetype -eq "USB"} | %{gwmi -Query "ASSOCIATORS OF {Win32_DiskDrive.DeviceID=`"$($_.DeviceID.replace('\','\\'))`"} WHERE AssocClass = Win32_DiskDriveToDiskPartition"} |  %{gwmi -Query "ASSOCIATORS OF {Win32_DiskPartition.DeviceID=`"$($_.DeviceID)`"} WHERE AssocClass = Win32_LogicalDiskToPartition"} | %{$_.deviceid};
        $Global:usbDir = $dLetter.TrimEnd(" ")+"\*";
        if(($Global:usbDir))
        {

        }
        CheckDirs;

    }
    catch
    {
        Write-Host "No USB-Flashdrive is connected to the computer";
        ClearVariables;
        Exit;
    }

}

AutoSelect;

#-- End of application --