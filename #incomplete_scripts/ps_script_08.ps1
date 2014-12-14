#-- Version History --
#Version:         01.000           
#Creation:        01.12.2014 
#Author:          Jevgeni Ziebart
#Description:     The following script copies all files from a USB-Flashdrive to your harddisk.

#-- Version Changes --
#01.12.2014:      initial commit

#-- Code Section --

#ToDo
#


$Global:usb_dir;
$Global:hdd_dir;

Function copy_files()
{
    try
    {
        Copy-Item $Global:usb_dir $Global:hdd_Dir -Recurse -Force;
        echo "Your files were successfully copied to $hdd_dir";
        delete_files;
    }
    catch
    {
        echo "File Copy Error, restart?"
        Pause;
        copy_files;
    }
}

Function check_dirs()
{
    $Global:hdd_dir = Read-Host "Where do you want to save your flashdrive files?";
    try
    {
        if((Test-Path -Path $Global:hdd_dir) -eq 0)
        {
            New-Item $Global:hdd_dir -type directory;
            copy_files;
        }
        else
        {
            copy_files;
        }
    }
    catch
    {
        echo "Folder couldn't be created, restart?"
        Pause;
        check_dirs;
    }
}

Function delete_files()
{
    $delete = Read-Host "Do you want to delete any file on your flashdrive? y/n";
    try
    {
        if(($delete) -eq "y")
        {
            Remove-Item -Recurse -path $Global:usb_dir;
            echo "Your files were deleted";
        }
        else
        {
            Exit;
        }
    }
    catch
    {
        echo "Your files couldn't be deleted, restart?";
        Pause;
        delete_files;    
    }
}

Function auto_select()
{   
    try
    {
        $d_letter = gwmi win32_diskdrive | ?{$_.interfacetype -eq "USB"} | %{gwmi -Query "ASSOCIATORS OF {Win32_DiskDrive.DeviceID=`"$($_.DeviceID.replace('\','\\'))`"} WHERE AssocClass = Win32_DiskDriveToDiskPartition"} |  %{gwmi -Query "ASSOCIATORS OF {Win32_DiskPartition.DeviceID=`"$($_.DeviceID)`"} WHERE AssocClass = Win32_LogicalDiskToPartition"} | %{$_.deviceid};
        $d_letter = $d_letter.Replace(" ","").Replace(":","");
        if(($d_letter.Length) -eq 1)
        {
            echo "Flashdrive Driveletter: "$d_letter;
            check_dirs;
        }
        else
        {
            echo "You have connected more than 1 USB-Flashdrive to your PC, please select the USB-Flashdrive Driveletter you want to copy your files from."
            echo $d_letter;
            $user_letter = Read-Host;
            if($d_letter.contains($user_letter))
            {
                $Global:usb_dir = $user_letter + ":\*";
                check_dirs;
            }
            else
            {
                echo "You have selected a Driveletter to an non existing file. Please select a Driveletter to an existing Device";
                Pause;
                auto_select;
            }
        }

    }
    catch
    {
        echo "No USB-Flashdrive is connected to the computer";
        echo "Please connect a USB-Flashdrive to the computer";
        Pause;
        auto_select;
    }

}

auto_select;

#-- End of application --