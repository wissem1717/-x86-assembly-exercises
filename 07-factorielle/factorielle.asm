; === factorielle.asm ===
; Ce programme lit un entier au clavier, puis calcule sa factorielle
; avec une fonction récursive factorielle(n).

.386
.model flat, stdcall
option casemap:none

include C:\masm32\include\windows.inc
include C:\masm32\include\kernel32.inc
include C:\masm32\include\msvcrt.inc

includelib C:\masm32\lib\kernel32.lib
includelib C:\masm32\lib\msvcrt.lib

.data
    msg_ask     db "Entrez un entier n : ", 0
    msg_fmt     db "%d", 0
    msg_result  db "n! = %d", 13, 10, 0
    n           dd ?

.code
start:

    ; Afficher une demande pour entrer un entier
    push offset msg_ask
    call crt_printf

    ; Lire un entier avec scanf("%d", &n)
    push offset n
    push offset msg_fmt
    call crt_scanf
    add esp, 8

    ; Appeler la fonction factorielle(n)
    push dword ptr [n]
    call factorielle
    add esp, 4

    ; Résultat est dans EAX → affichage
    push eax
    push offset msg_result
    call crt_printf
    add esp, 8

    ; Fin propre du programme
    call ExitProcess

; === Fonction récursive : factorielle(n) ===
; Si n <= 1 → return 1
; Sinon     → return n * factorielle(n-1)
factorielle PROC
    push ebp
    mov ebp, esp

    mov eax, [ebp+8]   ; charger n dans eax
    cmp eax, 1
    jg recursive_case

    ; Cas de base : n <= 1
    mov eax, 1
    jmp fin

recursive_case:
    dec eax            ; eax = n - 1
    push eax           ; appel récursif : factorielle(n - 1)
    call factorielle
    add esp, 4         ; nettoyage de la pile

    ; Multiplier par n
    mov ecx, [ebp+8]
    imul eax, ecx      ; eax = n * factorielle(n-1)

fin:
    pop ebp
    ret
factorielle ENDP

END start
