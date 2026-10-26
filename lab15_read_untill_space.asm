.model small
.stack 100h
.data
.code
main proc
    mov ax, @data
    mov ds, ax

read_char:
    mov ah, 1h       ; read character from keyboard (with echo)
    int 21h
    cmp al, ' '      ; compare input with space (blank)
    je exit_prog     ; if space, exit

    ; Otherwise, keep reading
    jmp read_char

exit_prog:
    mov ah, 4Ch      ; terminate program
    int 21h
main endp
end main
