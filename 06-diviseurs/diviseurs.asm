; Programme : diviseurs.asm
; Objectif : Lire un entier positif au clavier et afficher tous ses diviseurs

.386
.model flat, stdcall
option casemap:none

include C:\masm32\include\windows.inc
include C:\masm32\include\kernel32.inc
include C:\masm32\include\msvcrt.inc

includelib C:\masm32\lib\kernel32.lib
includelib C:\masm32\lib\msvcrt.lib

.data
    buffer      db 11 dup(0)              ; Pour stocker la saisie clavier (max 10 chiffres + NULL)
    msg_ask     db "Entrez un entier : ", 0
    msg_fmt     db "%d", 0
    msg_aff     db "%d ", 0

.code
start:

    ; Afficher un message pour demander un entier
    push offset msg_ask
    call crt_printf

    ; Lire un entier depuis le clavier avec scanf
    push offset buffer      ; scanf("%d", &buffer)
    push offset msg_fmt
    call crt_scanf
    add esp, 8

    ; Charger la valeur entière entrée dans EAX
    mov eax, dword ptr [buffer]   ; EAX = valeur entrée

    ; Initialiser le compteur à 1 (commencer à tester les diviseurs depuis 1)
    mov ebx, 1

boucle:
    cmp ebx, eax          ; Tant que EBX <= EAX
    jg fin

    mov edx, 0            ; Pour la division propre (éviter les restes antérieurs)
    mov ecx, ebx
    div ecx               ; EAX / EBX, reste dans EDX

    cmp edx, 0            ; Si le reste est 0, alors c’est un diviseur
    jne pas_afficher

    ; Afficher EBX (le diviseur)
    push ebx
    push offset msg_aff
    call crt_printf
    add esp, 8

pas_afficher:
    inc ebx               ; Passer au nombre suivant
    mov eax, dword ptr [buffer]
    jmp boucle

fin:
    call ExitProcess

END start
