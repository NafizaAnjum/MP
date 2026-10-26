.model small
.stack 100h
.data
    msg1 db 'Enter first digit (0-9): $'
    msg2 db 13, 10, 'Enter second digit (0-9): $'
    msg3 db 13, 10, 'First popped value: $'
    msg4 db 13, 10, 'Second popped value: $'
    digit1 db ?
    digit2 db ?

.code
main proc
    mov ax, @data
    mov ds, ax

    ; Prompt for first digit
    mov dx, offset msg1
    call display
    call read_char
    mov digit1, al  ; Store first digit
    push ax         ; Push first digit to stack

    ; Prompt for second digit
    mov dx, offset msg2
    call display
    call read_char
    mov digit2, al  ; Store second digit
    push ax         ; Push second digit to stack

    ; --- POP first (should be second input) ---
    pop bx
    mov dx, offset msg3
    call display
    
    call display_char

    ; --- POP second (should be first input) ---
    pop bx
    mov dx, offset msg4
    call display
    
    call display_char

    ; Exit program
    mov ah, 4ch
    int 21h

; --------------------------
; Display a string (offset in DX)
; --------------------------
display:
    mov ah, 09h
    int 21h
    ret

; --------------------------
; Read one character into AL
; --------------------------
read_char:
    mov ah, 01h
    int 21h
    ret

; --------------------------
; Display character in DL
; --------------------------
display_char:
    mov dl, bl
    mov ah, 02h
    int 21h
    ret
 
main endp
end main
