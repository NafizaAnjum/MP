.model small
.stack 100h
.data
    num1 dw ?                ; First number
    num2 dw ?                ; Second number
    msg1 db 'First: $'
    msg2 db 'Second: $' 
    msg3 db 'Sum: $'
    msg4 db 'Diff: $'
.code
main:
    mov ax, @data
    mov ds, ax

    ; ===== Get first number =====
    mov dx, offset msg1
    mov ah, 09h
    int 21h

    call InputNumber          ; Read number from user
    mov num1, ax              ; Store into num1
    call PrintNewLine         ; Move to next line

    ; ===== Get second number =====
    mov dx, offset msg2
    mov ah, 09h
    int 21h

    call InputNumber
    mov num2, ax
    call PrintNewLine

    ; ===== Show sum =====
    mov dx, offset msg3
    mov ah, 09h
    int 21h

    mov ax, num1
    add ax, num2
    call PrintNumber
    call PrintNewLine

    ; ===== Show difference =====
    mov dx, offset msg4
    mov ah, 09h
    int 21h

    mov ax, num1
    cmp ax, num2
    jge positiveDiff          ; If num1 >= num2, go subtract normally

    ; If difference is negative, print '-'
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
; Procedure: InputNumber
; Reads a multi-digit number from user (ends on Enter)
; Returns: AX = decimal number
; =====================================
InputNumber proc
    xor ax, ax                ; Clear AX
    xor bx, bx                ; BX will store the current value

readLoop:
    mov ah, 01h                ; Read a character
    int 21h
    cmp al, 13                 ; Check if Enter was pressed
    je doneInput

    sub al, '0'                ; Convert ASCII to number
    mov cl, al                 ; Store digit in CL

    mov ax, bx                 ; AX = current total
    mov bx, 10
    mul bx                     ; Multiply by 10
    add al, cl                 ; Add new digit
    mov bx, ax                 ; Save result in BX
    jmp readLoop

doneInput:
    mov ax, bx                 ; Final result into AX
    ret
InputNumber endp

; =====================================
; Procedure: PrintNumber
; Prints a number in AX as decimal
; =====================================
PrintNumber proc
    cmp ax, 0
    jne convertToDigits

    ; If number is zero, just print '0'
    mov dl, '0'
    mov ah, 02h
    int 21h
    ret

convertToDigits:
    mov bx, 10
    xor cx, cx                 ; CX = digit count

divideLoop:
    xor dx, dx                 ; Clear DX for division
    div bx                     ; AX / 10, remainder in DX
    push dx                    ; Store remainder (digit) on stack
    inc cx                     ; Increase digit count
    test ax, ax
    jnz divideLoop              ; Continue until AX = 0

printLoop:
    pop dx                     ; Get digit from stack
    add dl, '0'                 ; Convert to ASCII
    mov ah, 02h
    int 21h
    loop printLoop
    ret
PrintNumber endp

; =====================================
; Procedure: PrintNewLine
; Prints a new line (CR + LF)
; =====================================
PrintNewLine proc
    mov ah, 02h
    mov dl, 13                  ; Carriage return
    int 21h
    mov dl, 10                  ; Line feed
    int 21h
    ret
PrintNewLine endp

end main
