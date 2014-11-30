:: Beispiel für eine Prüfung, ob ein Parameter leer ist

if  "%1" == "" goto leer
goto voll

:leer
echo der Eintrag ist leer
goto exit

:voll
echo der Eintrag ist voll
goto exit

:exit
pause

