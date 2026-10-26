.model small
.stack 100h
.data
    num1 dw ?
    num2 dw ?
    result dw ?
    msg1 db 'Enter first number: $'
    msg2 db 13,10,'Enter second number: $'
    msg_mul db 13,10,'Multiplication Result: $'
    msg_div db 13,10,'Division Result: $'
    newline db 13,10,'$'

.code
main:
    mov ax, @data
    mov ds, ax

    ; --- Prompt for first number ---
    lea dx, msg1
    mov ah, 09h
    int 21h

    call read_num
    mov num1, ax

    ; --- Prompt for second number ---
    lea dx, msg2
    mov ah, 09h
    int 21h

    call read_num
    mov num2, ax

    ; --- Multiplication ---
    mov ax, num1
    mov bx, num2
    mul bx
    mov result, ax

    ; Display multiplication result
    lea dx, msg_mul
    mov ah, 09h
    int 21h
    mov ax, result
    call print_num

    ; --- Division ---
    mov ax, num1
    mov bx, num2
    xor dx, dx
    div bx
    mov result, ax

    ; Display division result
    lea dx, msg_div
    mov ah, 09h
    int 21h
    mov ax, result
    call print_num

    ; Exit
    mov ah, 4Ch
    int 21h

; --- Subroutine to read number from user ---
read_num proc
    xor ax, ax         ; Clear AX
    xor bx, bx         ; Clear BX
    xor cx, cx         ; Digit counter

read_loop:
    mov ah, 01h        ; Read character
    int 21h
    cmp al, 13         ; Enter key?
    je done_read
    sub al, '0'        ; Convert ASCII to digit
    mov bl, al
    mov dx, ax         ; Save current AX
    mov ax, cx
    mov si, 10
    mul si             ; AX = AX * 10
    add ax, bx         ; AX = AX + digit
    mov cx, ax
    jmp read_loop

done_read:
    mov ax, cx         ; Final result in AX
    ret
read_num endp

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
