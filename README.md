# Exercices d'assembleur x86

[![ASM](https://img.shields.io/badge/Assembleur-x86%20(MASM32)-6E4C1E?style=for-the-badge)]()
[![École](https://img.shields.io/badge/ENSIBS-Architecture%20des%20ordinateurs-0A66C2?style=for-the-badge)](https://www.ensibs.fr/)

> Série d'exercices en assembleur x86 (syntaxe MASM32, `stdcall`) : manipulation de chaînes, appels par pile, récursivité, arithmétique bas niveau. Comprendre ce qui se passe **sous** un langage haut niveau — registres, pile d'appel, conventions d'appel — est une base directement utile en rétro-ingénierie et en analyse de binaires.

## Exercices

| # | Exercice | Notions travaillées |
|---|---|---|
| [01](./01-majuscules) | Conversion d'une chaîne en majuscules | Boucle sur une chaîne, manipulation d'octets |
| [02](./02-appel-par-pile) | Appel de routine par passage d'adresse via la pile | Convention d'appel, passage de paramètres par la pile |
| [03](./03-compter-caracteres) | Longueur d'une chaîne sans `strlen` | Parcours mémoire, terminaison par octet nul |
| [04](./04-fonction-mystere) | Réécriture en assembleur d'une fonction C avec variables locales | Frame de pile (`ebp`/`esp`), variables locales |
| [05](./05-compter-lettres) | Comptage d'occurrences de lettres (`a`, `b`, `c`) | Utilisation combinée de plusieurs registres (`eax`, `ebx`, `ecx`) |
| [06](./06-diviseurs) | Calcul et affichage des diviseurs d'un entier | Boucles, division entière, tests de modulo |
| [07](./07-factorielle) | Factorielle récursive | **Récursivité** : empilement de contextes, valeur de retour dans `eax` |

Chaque dossier contient le fichier `.asm`, son script de build (`make.bat`, pour MASM32) et, quand disponible, une capture d'écran du résultat d'exécution.

## Exemple — factorielle récursive ([`07-factorielle/factorielle.asm`](./07-factorielle/factorielle.asm))

```asm
factorielle PROC
    push ebp
    mov ebp, esp
    mov eax, [ebp+8]   ; n
    cmp eax, 1
    jg recursive_case
    mov eax, 1         ; cas de base : n <= 1
    jmp fin
recursive_case:
    dec eax
    push eax
    call factorielle   ; appel récursif
    add esp, 4
    mov ecx, [ebp+8]
    imul eax, ecx      ; n * factorielle(n-1)
fin:
    pop ebp
    ret
factorielle ENDP
```

## Compiler et exécuter

Nécessite [MASM32](https://www.masm32.com/) (Windows).

```bat
cd 07-factorielle
make.bat
factorielle.exe
```

## Ce que ce projet démontre

- Compréhension fine de la **pile d'appel** et des conventions d'appel (`stdcall`)
- Traduction manuelle de structures haut niveau (boucles, récursivité, variables locales) en instructions machine
- Base solide pour l'analyse de binaires et la rétro-ingénierie

---

*Travaux pratiques — ENSIBS, cours d'architecture des ordinateurs / assembleur.*
