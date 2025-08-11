.model small
.stack 100h
.code
main:
    mov ah, 01h       ; read character
    int 21h
    cmp al, 'Y'
    je show_char
    cmp al, 'y'
    je show_char
    jmp exit          ; if not Y/y, exit

show_char:
    mov dl, al
    mov ah, 02h       ; display character
    int 21h

exit:
    mov ah, 4Ch
    int 21h
end main
