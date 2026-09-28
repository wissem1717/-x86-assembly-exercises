@echo off
echo [*] Assemblage de diviseurs.asm ...
C:\masm32\bin\ml /c /coff diviseurs.asm

echo.
echo [*] Edition de liens ...
C:\masm32\bin\link /subsystem:console diviseurs.obj

echo.
echo [*] Execution de diviseurs.exe ...
diviseurs.exe

pause
