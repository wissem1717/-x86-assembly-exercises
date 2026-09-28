; Fichier : appel_par_pile.asm
; Objectif : Appeler une routine qui met en majuscule une chaîne,
;            en passant l'adresse par la pile (Partie B.b)

.386
.model flat,stdcall
option casemap:none

include C:\masm32\include\windows.inc
include C:\masm32\include\kernel32.inc
include C:\masm32\include\msvcrt.inc

includelib C:\masm32\lib\kernel32.lib
includelib C:\masm32\lib\msvcrt.lib

.DATA
    chaine db "bienvenue les cybers", 0
    format db "Resultat : %s", 13, 10, 0

.CODE
start:

    ; On pousse l'adresse de la chaîne dans la pile
    push offset chaine
    ; Appel de la procédure de mise en majuscule
    call to_uppercase
    add esp, 4   ; on nettoie la pile après l'appel

    ; On affiche la chaîne transformée avec printf
    push offset chaine
    push offset format
    call crt_printf
    add esp, 8   ; 2 arguments empilés

    ; Fin propre du programme
    push 0
    call ExitProcess

; ----------------------------------------------------------------
; PROC : to_uppercase
; Entrée : [esp+4] contient l'adresse de la chaîne à modifier
; ----------------------------------------------------------------
to_uppercase PROC
    push ebp
    mov ebp, esp
    mov esi, [ebp+8]  ; récupérer l'adresse passée par la pile

boucle:
    mov al, [esi]
    cmp al, 0
    je fin

    cmp al, 'a'
    jb suite
    cmp al, 'z'
    ja suite

    sub al, 32
    mov [esi], al

suite:
    inc esi
    jmp boucle

fin:
    pop ebp
    ret 4  ; nettoyage de la pile (1 argument)
to_uppercase ENDP

END start
