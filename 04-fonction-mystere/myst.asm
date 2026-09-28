; myst.asm — Réécriture en assembleur de la fonction C myst(int n)
; Cette fonction utilise des variables locales (j, k, l)
; Elle retourne un int comme en C

.386
.model flat, stdcall
option casemap:none

include C:\masm32\include\windows.inc
include C:\masm32\include\kernel32.inc
include C:\masm32\include\msvcrt.inc

includelib C:\masm32\lib\kernel32.lib
includelib C:\masm32\lib\msvcrt.lib


.data
msg_result db "Resultat final : %d", 13, 10, 0

.code

start:
    ; Initialisation de la pile d’appel standard
    push ebp
    mov ebp, esp

    ; Simule myst(7) par exemple => push 7
    push 7
    call myst
    add esp, 4        ; Nettoyage de la pile

    ; Affichage du résultat avec printf
    push eax          ; EAX contient le résultat
    push offset msg_result
    call crt_printf
    add esp, 8

    ; Fin du programme
    call ExitProcess

; === Fonction myst(n) ===
; On suppose que n est passé via [ebp+8]
; Variables locales : j, k, l, i (on les empile)

myst PROC
    push ebp
    mov ebp, esp
    sub esp, 16            ; Réserve 16 octets pour i, j, k, l

    ; Placement des variables sur la pile :
    ; [ebp-4] = i
    ; [ebp-8] = j
    ; [ebp-12] = k
    ; [ebp-16] = l

    ; Initialisation j = 1, k = 1
    mov dword ptr [ebp-8], 1
    mov dword ptr [ebp-12], 1

    ; i = 3
    mov dword ptr [ebp-4], 3

boucle:
    mov eax, [ebp-4]       ; i
    cmp eax, [ebp+8]       ; i <= n ?
    jg fin_boucle

    ; l = j + k
    mov eax, [ebp-8]
    add eax, [ebp-12]
    mov [ebp-16], eax

    ; j = k
    mov eax, [ebp-12]
    mov [ebp-8], eax

    ; k = l
    mov eax, [ebp-16]
    mov [ebp-12], eax

    ; i++
    inc dword ptr [ebp-4]
    jmp boucle

fin_boucle:
    ; Retourner k
    mov eax, [ebp-12]

    mov esp, ebp
    pop ebp
    ret
myst ENDP

END start
