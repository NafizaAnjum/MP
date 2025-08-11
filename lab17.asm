.model small
.stack 100h
.data
.code
main proc
    mov ax, @data
    mov ds, ax

    mov dl, '?'    ; ASCII code for '?'
    mov ah, 2h     ; DOS function to display character
    int 21h        ; call DOS interrupt

    mov ah, 4Ch    ; terminate program
    int 21h
main endp
end main
