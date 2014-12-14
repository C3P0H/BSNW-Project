#-- Version History --
#Version:         01.000           
#Creation:        2.12.2014 
#Author:          Lars Wrzeziono
#Description:     The following script switch the name of two Files.

#-- Version Changes --
#2.12.2014:      Inital commit.

#-- Code Section --

$Global:document_1_path = "";
$Global:document_2_path = "";
$Global:document1 = "";
$Global:document2 = "";
$Global:random = Get-Random;

# Getting the Filenames
Function GetFilesname () 
{
    
    $Global:document_1_path = Read-Host "document one";
    $Global:document_2_path = Read-Host "document two";
    $Global:document_1 = Split-Path $Global:document_1_path -Leaf
    $Global:document_2 = Split-Path $Global:document_2_path -Leaf

    if((Test-Path $Global:document_1) -eq 0)
    {
        echo "$Global:document_1 does not exist";
        pause;
        GetFilesname;
    }
    if((Test-Path $Global:document_2) -eq 0)
    {
        echo "$Global:document_2 does not exist";
        pause;
        GetFilesname;
    }

     Changename;
}

# Swap the Filenames
Function ChangeName()
{

    $change = Read-Host "Would you really swap the names? [y/n]";
    
    if($change -eq "y")
    {
        Rename-Item $Global:document_1 $Global:random;
        Rename-Item $Global:document_2 $Global:document_1;
        Rename-Item $Global:random $Global:document_2;
        echo "Names Swaped";
    }
    else
    {
       echo "Names not swaped"; 
       pause;
       exit;
    } 
}
GetFilesname;
pause;

#-- End of application --