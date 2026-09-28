@echo off
cd /d %~dp0
echo [*] Assemblage de compteur.asm ...
C:\masm32\bin\ml /c /coff compteur.asm
C:\masm32\bin\link /subsystem:console compteur.obj
echo.
echo [*] Execution de compteur.exe ...
compteur.exe
pause
