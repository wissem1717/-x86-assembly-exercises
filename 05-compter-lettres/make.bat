@echo off
echo [*] Assemblage de compter_lettres.asm ...
C:\masm32\bin\ml /c /coff compter_lettres.asm
if errorlevel 1 goto :error

echo [*] Édition de lien ...
C:\masm32\bin\link /subsystem:console compter_lettres.obj
if errorlevel 1 goto :error

echo.
echo [*] Execution de compter_lettres.exe ...
compter_lettres.exe
pause
exit

:error
echo [!] Une erreur s’est produite.
pause
