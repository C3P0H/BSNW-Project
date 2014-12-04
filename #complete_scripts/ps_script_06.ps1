#-- Version History --
#Version:         01.000           
#Creation:        2.12.2014 
#Author:          Lars Wrzeziono
#Description:     The following script switch the name of two Files.

#-- Version Changes --
#2.12.2014:      Inital commit.

#-- Code Section --
 
$Global:document_1 = "";
$docoment_2 = "";
$rand = Get-Random;

Function get_filename () 
{
    
    $doc1 = Read-Host "document one";
    $doc2 = Read-Host "document two";

    if((Test-Path $doc1) -eq 0)
    {
        echo "$doc1 does not exist";
        pause;
        exit
    }
    if((Test-Path $doc2) -eq 0)
    {
        echo "$doc2 does not exist";
        pause;
        exit
    }

     Changename;
}

Function ChangeName()
{

    $change = Read-Host "Would you like to swap the names? [y/n]";
    
    if($change -eq "y")
    {
        Rename-Item $doc1 $rand;
        Rename-Item $doc2 $doc1;
        Rename-Item $rand $doc2;
        echo "Names switched";
    }
    else
    {
       echo "Names not switched"; 
       pause;
       exit;
    } 
}
GetFilesname;
pause;

#-- End of application --