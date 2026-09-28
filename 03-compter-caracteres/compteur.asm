; Fichier : compteur.asm
; Objectif : Afficher une chaîne de caractères et calculer sa longueur sans utiliser strlen C.

.386
.model flat,stdcall
option casemap:none

include C:\masm32\include\windows.inc
include C:\masm32\include\kernel32.inc
include C:\masm32\include\msvcrt.inc

includelib C:\masm32\lib\kernel32.lib
includelib C:\masm32\lib\msvcrt.lib

.DATA
    chaine db "CYBERLOG", 0           ; texte d'exemple
    format_chaine db "Texte original : %s", 13,10,0 ; format pour afficher la chaîne
    format_len    db "Longueur de la chaine : %d", 13,10,0 ; format pour afficher la taille

.CODE
start:

    ; afficher la chaîne d'abord
    push offset chaine
    push offset format_chaine
    call crt_printf
    add esp, 8

    ; appel de la routine de comptage via la pile
    push offset chaine
    call compte_longueur
    add esp, 4

    ; eax contient la longueur
    push eax
    push offset format_len
    call crt_printf
    add esp, 8

    push 0
    call ExitProcess

; ---------------------------------------------------------------
; PROC : compte_longueur
; Entrée : [esp+4] = adresse de la chaîne
; Sortie : eax = nombre de caractères jusqu’au 0 final
; ---------------------------------------------------------------
compte_longueur PROC
    push ebp
    mov ebp, esp

    mov esi, [ebp+8]   ; récupérer l'adresse de la chaîne
    xor ecx, ecx       ; compteur = 0

compte_loop:
    mov al, [esi]
    cmp al, 0
    je fin_compte
    inc ecx
    inc esi
    jmp compte_loop

fin_compte:
    mov eax, ecx       ; retour du compteur dans eax
    pop ebp
    ret 4              ; nettoyer 1 argument sur la pile
compte_longueur ENDP

END start
