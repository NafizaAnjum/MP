.model small
.stack 100h
.data
    msg1 db 13,10, "Enter first number: $"
    msg2 db 13,10, "Enter second number: $"
    result_msg db 13,10, "Maximum is: $"

.code
main proc
    mov ax, @data
    mov ds, ax

    ; ===== First number =====
    lea dx, msg1
    mov ah, 9
    int 21h

    mov ah, 1         ; read char
    int 21h
    sub al, '0'       ; convert ASCII to number
    mov bl, al        ; store first number in BL

    ; ===== Second number =====
    lea dx, msg2
    mov ah, 9
    int 21h

    mov ah, 1
    int 21h
    sub al, '0'       ; convert to number
    mov bh, al        ; store second number in BH

    ; ===== Compare =====
    cmp bl, bh
    jge first_bigger  ; if BL >= BH, jump
    mov bl, bh        ; else, BL = BH
first_bigger:

    ; ===== Show result =====
    lea dx, result_msg
    mov ah, 9
    int 21h

    mov dl, bl
    add dl, '0'       ; convert back to ASCII
    mov ah, 2
    int 21h

    ; exit
    mov ah, 4Ch
    int 21h
main endp
end main
