@echo off
cd /d %~dp0
echo [*] Assemblage de appel_par_pile.asm ...
C:\masm32\bin\ml /c /coff appel_par_pile.asm
C:\masm32\bin\link /subsystem:console appel_par_pile.obj
echo.
echo [*] Execution de appel_par_pile.exe ...
appel_par_pile.exe
pause
