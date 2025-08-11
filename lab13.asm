; Find maximum of 3 numbers in 8086 Assembly (0–999 range)
.model small
.stack 100h
.data
    msg1 db 'Enter first number: $'
    msg2 db 13,10,'Enter second number: $'
    msg3 db 13,10,'Enter third number: $'
    msg_max db 13,10,'Maximum: $'

    num1 dw ?
    num2 dw ?
    num3 dw ?
    maxnum dw ?

.code
main:
    mov ax, @data
    mov ds, ax

    ; === Get first number ===
    mov dx, offset msg1
    mov ah, 09h
    int 21h
    call ReadNumber
    mov num1, ax

    ; === Get second number ===
    mov dx, offset msg2
    mov ah, 09h
    int 21h
    call ReadNumber
    mov num2, ax

    ; === Get third number ===
    mov dx, offset msg3
    mov ah, 09h
    int 21h
    call ReadNumber
    mov num3, ax

    ; === Compare to find max ===
    mov ax, num1
    mov bx, num2
    cmp ax, bx
    jge skip1
    mov ax, bx
skip1:
    mov bx, num3
    cmp ax, bx
    jge skip2
    mov ax, bx
skip2:
    mov maxnum, ax

    ; === Display maximum ===
    mov dx, offset msg_max
    mov ah, 09h
    int 21h
    mov ax, maxnum
    call PrintNumber

    ; Exit
    mov ah, 4Ch
    int 21h

; ========================
; ReadNumber: reads up to 3 digits and returns AX = number
; ========================
ReadNumber proc
    xor ax, ax
    xor bx, bx
    mov cx, 0
read_loop:
    mov ah, 01h
    int 21h
    cmp al, 13         ; Enter pressed?
    je done_read
    sub al, '0'
    mov bl, al
    mov dx, ax
    mov ax, cx
    mov cx, 10
    mul cx
    add ax, bx
    mov cx, ax
    jmp read_loop
done_read:
    mov ax, cx
    ret
ReadNumber endp

; ========================
; PrintNumber: prints AX in decimal
; ========================
PrintNumber proc
    mov cx, 0
    mov bx, 10
    cmp ax, 0
    jne pn_loop
    mov dl, '0'
    mov ah, 02h
    int 21h
    ret

pn_loop:
    xor dx, dx
    div bx
    push dx
    inc cx
    test ax, ax
    jnz pn_loop

pn_print:
    pop dx
    add dl, '0'
    mov ah, 02h
    int 21h
    loop pn_print
    ret
PrintNumber endp

end main
