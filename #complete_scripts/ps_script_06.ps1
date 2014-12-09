#-- Version History --
#Version:         01.000           
#Creation:        2.12.2014 
#Author:          Lars Wrzeziono
#Description:     The following script switch the name of two Files.

#-- Version Changes --
#2.12.2014:      Inital commit.

#-- Code Section --

$document_1_path = "";
$document_2_path = "";
$document1 = "";
$document2 = "";
$random = Get-Random;


Function GetFilesname () 
{
    
    $document_1_path = Read-Host "document one";
    $document_2_path = Read-Host "document two";
    $document_1 = Split-Path $document_1_path -Leaf
    $document_2 = Split-Path $document_2_path -Leaf

    if((Test-Path $document_1) -eq 0)
    {
        echo "$document_1 does not exist";
        pause;
        GetFilesname;
    }
    if((Test-Path $document_2) -eq 0)
    {
        echo "$document_2 does not exist";
        pause;
        GetFilesname;
    }

     Changename;
}

Function ChangeName()
{

    $change = Read-Host "Would you really swap the names? [y/n]";
    
    if($change -eq "y")
    {
        Rename-Item $document_1 $random;
        Rename-Item $document_2 $document_1;
        Rename-Item $random $document_2;
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