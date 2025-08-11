.model small
.stack 100h
.data
    num1 dw ?                ; First number
    num2 dw ?                ; Second number
    msg1 db 'First: $'
    msg2 db 13,10, 'Second: $' 
    msg3 db 13,10, 'Sum: $'
    msg4 db 13,10, 'Diff: $'
.code
main:
    mov ax, @data
    mov ds, ax

    ; ===== Get first number =====
    mov dx, offset msg1
    mov ah, 09h
    int 21h

    call ReadNumber          ; Read number from user
    mov num1, ax            ; Store into num1
    

    ; ===== Get second number =====
    mov dx, offset msg2
    mov ah, 09h
    int 21h

    call ReadNumber
    mov num2, ax
    

    ; ===== Show sum =====
    mov dx, offset msg3
    mov ah, 09h
    int 21h

    mov ax, num1
    add ax, num2
    call PrintNumber


    ; ===== Show difference =====
    mov dx, offset msg4
    mov ah, 09h
    int 21h

    mov ax, num1
    cmp ax, num2
    jge positiveDiff          ; If num1 >= num2, subtract normally

    ; If difference negative, print '-'
    mov dl, '-'
    mov ah, 02h
    int 21h

    mov ax, num2              ; ax = num2 - num1
    sub ax, num1
    jmp displayDiff

positiveDiff:
    sub ax, num2              ; ax = num1 - num2

displayDiff:
    call PrintNumber

    ; ===== Exit program =====
    mov ah, 4Ch
    int 21h

; =====================================
; Procedure: ReadNumber
; Reads multi-digit number from keyboard (ends on Enter)
; Returns: AX = decimal number
; =====================================
ReadNumber proc
    xor ax, ax
    xor bx, bx
    xor cx, cx         ; Use CX as accumulator (was 0 in your code)

read_loop:
    mov ah, 01h
    int 21h
    cmp al, 13         ; Enter pressed?
    je done_read

    sub al, '0'        ; Convert ASCII to digit 0-9

    mov bl, al         ; Store digit in BL
    
    mov ax, cx         ; Move current number into AX
    mov cx, 10
    mul cx             ; AX = AX * 10
    
    add ax, bx         ; Add new digit
    mov cx, ax         ; Save result in CX

    jmp read_loop

done_read:
    mov ax, cx         ; Return result in AX
    ret
ReadNumber endp

; =====================================
; Procedure: PrintNumber
; Prints number in AX as decimal
; =====================================
PrintNumber proc
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
PrintNumber endp


end main
