.model small
.stack 100h

.code
main proc
    mov ah, 01h
    int 21h          ; read char in AL
    mov bl, al       ; save original char

    ; print newline (CR + LF)
    mov ah, 02h
    mov dl, 13       ; CR
    int 21h
    mov dl, 10       ; LF
    int 21h

    ; check if uppercase A-Z (65-90)
    cmp bl, 'A'
    jl check_lowercase
    cmp bl, 'Z'
    jg check_lowercase

    ; uppercase to lowercase: add 32
    add bl, 32
    jmp print_char

check_lowercase:
    ; check if lowercase a-z (97-122)
    cmp bl, 'a'
    jl print_char    ; if less, not alphabet, print as is
    cmp bl, 'z'
    jg print_char    ; if greater, not alphabet, print as is

    ; lowercase to uppercase: subtract 32
    sub bl, 32

print_char:
    mov dl, bl
    mov ah, 02h
    int 21h

exit:
    mov ah, 4Ch
    int 21h

main endp
end main
