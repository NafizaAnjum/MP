.model small
.stack 100h
.data
.code
main proc
    mov ax, @data
    mov ds, ax

    ; Read first character (capital letter)
    mov ah, 1h
    int 21h
    mov bl, al       ; store first char in BL

    ; Read second character (capital letter)
    mov ah, 1h
    int 21h
    mov bh, al       ; store second char in BH

    ; Compare BL and BH
    cmp bl, bh
    jbe display_order ; if BL <= BH jump to display_order

    ; If BL > BH, swap BL and BH
    xchg bl, bh

display_order:
    ; Display first char in BL
    mov dl, bl
    mov ah, 2h
    int 21h

    ; Display second char in BH
    mov dl, bh
    mov ah, 2h
    int 21h

    ; Exit program
    mov ah, 4Ch
    int 21h
main endp
end main
