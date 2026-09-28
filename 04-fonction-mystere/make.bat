@echo off
echo [*] Assemblage de myst.asm ...
C:\masm32\bin\ml /c /coff myst.asm
if errorlevel 1 goto :error

echo [*] Edition de liens ...
C:\masm32\bin\link /subsystem:console myst.obj
if errorlevel 1 goto :error

echo.
echo [*] Execution de myst.exe ...
myst.exe
pause
exit

:error
echo [!] Une erreur s'est produite lors de l'assemblage ou du linkage.
pause
