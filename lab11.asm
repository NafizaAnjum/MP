.model small
.stack 100h
.data
    msg db 'Sum of 1 to 4 is: $'

.code
main:
    mov ax, @data
    mov ds, ax

    ; Display message
    lea dx, msg
    mov ah, 09h
    int 21h

    ; Compute sum: 1 + 2 + 3 + 4
    mov ax, 1
    add ax, 2
    add ax, 3
    add ax, 4

    ; AX now contains 10
    call print_num

    ; Exit
    mov ah, 4Ch
    int 21h

; --- Subroutine to print number in AX ---
print_num proc
    mov cx, 0
    mov bx, 10

convert_loop:
    xor dx, dx
    div bx
    push dx
    inc cx
    cmp ax, 0
    jne convert_loop

print_loop:
    pop dx
    add dl, '0'
    mov ah, 02h
    int 21h
    loop print_loop
    ret
print_num endp

end main
