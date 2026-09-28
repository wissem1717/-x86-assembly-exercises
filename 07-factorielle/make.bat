@echo off
echo [*] Assemblage de factorielle.asm ...
C:\masm32\bin\ml /c /coff factorielle.asm
if errorlevel 1 goto erreur

echo.
echo [*] Edition de liens ...
C:\masm32\bin\link /subsystem:console factorielle.obj
if errorlevel 1 goto erreur

echo.
echo [*] Execution de factorielle.exe ...
factorielle.exe
pause
exit

:erreur
echo.
echo [!] Une erreur s’est produite pendant l’assemblage ou le linkage.
pause
