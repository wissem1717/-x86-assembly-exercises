@echo off
cd /d %~dp0
echo [*] Assemblage de majuscules.asm ...
C:\masm32\bin\ml /c /coff majuscules.asm
C:\masm32\bin\link /subsystem:console majuscules.obj
echo.
echo [*] Execution de majuscules.exe ...
majuscules.exe
pause
