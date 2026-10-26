.model small
.stack 100h
.data
.code
main proc
    mov ax, @data
    mov ds, ax

    mov cx, 80       ; loop counter = 80

print_star:
    mov dl, '*'      ; ASCII for star
    mov ah, 2h       ; DOS function to display char
    int 21h

    loop print_star  ; decrement CX, repeat if not zero

    mov ah, 4Ch      ; terminate program
    int 21h
main endp
end main
