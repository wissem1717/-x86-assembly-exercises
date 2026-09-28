; === compteur_lettres.asm ===
; Ce programme compte combien de fois les lettres 'a', 'b' et 'c' apparaissent
; dans une chaîne de caractères, en utilisant eax, ebx et ecx.

.386
.model flat, stdcall
option casemap:none

include C:\masm32\include\windows.inc
include C:\masm32\include\kernel32.inc
include C:\masm32\include\msvcrt.inc

includelib C:\masm32\lib\kernel32.lib
includelib C:\masm32\lib\msvcrt.lib

.data
chaine db "cabbaaccabc", 0   ; Chaîne à analyser
format db "a = %d, b = %d, c = %d", 13, 10, 0

.code
start:
    ; Initialisation des compteurs
    xor eax, eax    ; compteur pour 'a'
    xor ebx, ebx    ; compteur pour 'b'
    xor ecx, ecx    ; compteur pour 'c'

    ; Analyse de la chaîne
    lea esi, chaine

boucle:
    mov dl, [esi]       ; lire le caractère courant
    cmp dl, 0
    je afficher         ; si fin de chaîne, afficher

    cmp dl, 'a'
    jne pas_a
    inc eax
    jmp suivant

pas_a:
    cmp dl, 'b'
    jne pas_b
    inc ebx
    jmp suivant

pas_b:
    cmp dl, 'c'
    jne suivant
    inc ecx

suivant:
    inc esi
    jmp boucle

afficher:
    push ecx        ; compteur de 'c'
    push ebx        ; compteur de 'b'
    push eax        ; compteur de 'a'
    push offset format
    call crt_printf
    add esp, 16

    call ExitProcess
END start
