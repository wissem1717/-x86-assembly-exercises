; Fichier : majuscules.asm
; But : Routine qui convertit une chaîne en majuscules (Partie B.a du TP)

.386
.model flat,stdcall
option casemap:none

include C:\masm32\include\windows.inc
include C:\masm32\include\kernel32.inc
include C:\masm32\include\msvcrt.inc

includelib C:\masm32\lib\kernel32.lib
includelib C:\masm32\lib\msvcrt.lib


.DATA
    ma_chaine db "salUt les cyBerS", 0         ; chaîne test à modifier
    format_aff db "Chaine majuscule : %s", 13, 10, 0  ; format d'affichage printf

.CODE
start:

    ; On pousse l'adresse de la chaîne dans la pile
    push offset ma_chaine
    ; Appel de notre routine maison pour convertir
    call majuscules
    add esp, 4       ; on nettoie la pile

    ; Affichage du résultat avec printf (autorisé car hors du segment MASM)
    push offset ma_chaine
    push offset format_aff
    call crt_printf
    add esp, 8       ; 2 paramètres

    ; Fin normale du programme
    push 0
    call ExitProcess

; ------------------------------------------------------------------
; Procédure : majuscules
; Entrée : [esp+4] = adresse de la chaîne à modifier
; But : transformer les lettres minuscules en majuscules (a-z ➜ A-Z)
; ------------------------------------------------------------------
majuscules PROC
    push ebp
    mov ebp, esp
    mov esi, [ebp+8]   ; récupération de l’adresse de la chaîne

convert_loop:
    mov al, [esi]      ; on lit le caractère courant
    cmp al, 0
    je fin_convert     ; si fin de chaîne, on sort

    cmp al, 'a'
    jb suite           ; si c’est avant 'a', on saute
    cmp al, 'z'
    ja suite           ; si c’est après 'z', on saute

    sub al, 32         ; conversion ASCII minuscule ➜ majuscule
    mov [esi], al      ; on modifie le caractère dans la chaîne

suite:
    inc esi            ; caractère suivant
    jmp convert_loop   ; on boucle

fin_convert:
    pop ebp
    ret 4              ; on enlève 1 paramètre passé (adresse)

majuscules ENDP

END start
