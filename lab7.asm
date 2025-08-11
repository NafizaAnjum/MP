.model small
.stack 100h
.data
    prompt db 'Enter number of terms (1-9): $'
    msg db 13,10,'Fibonacci series: $'
.code
main proc
    mov ax, @data
    mov ds, ax
    
    lea dx, prompt; Get user input
    mov ah, 9
    int 21h
    
    mov ah, 1 ;read input
    int 21h
    
    sub al, '0'     ; Convert ASCII to number
    mov cl, al      ; Store count in CL
    
    lea dx, msg    ; Print message
    mov ah, 9
    int 21h
    
    ; Initialize Fibonacci
    mov ax, 0        
    mov bx, 1         
    
print_fib:
    push ax
    call printnum    ;print number
    
    mov dl, ' '      ;print space
    mov ah, 2
    int 21h
    
    pop ax
    add ax, bx       
    xchg ax, bx
    
    dec cl          ; Use CL instead of CX
    jnz print_fib   ; Jump if not zero
    
    mov ah, 4ch
    int 21h
main endp
    
printnum proc
    push ax
    push bx
    push cx
    push dx
    
    xor cx, cx    ;cx == zero
    mov bx, 10    ;bx == 10
print_loop:
    xor dx, dx     ;dx==0
    div bx
    push dx        ;remainder in the dx
    inc cx
    test ax, ax
    jnz print_loop
print_digits:
    pop dx
    
    add dl, '0'    ;digit to ASCII
    mov ah, 2
    int 21h
    
    loop print_digits
    
    pop dx
    pop cx
    pop bx
    pop ax
    ret
printnum endp
end main