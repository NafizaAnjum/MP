.model small
.stack 100h
.data
    msg1 db 'Enter a string: $'
    msg2 db 13,10,'Reverse is: $'
.code
main proc
    mov ax, @data
    mov ds, ax

    lea dx, msg1
    mov ah, 9
    int 21h

read_loop:
    mov ah, 1        
    int 21h
    cmp al, 13        
    je print_reverse
    push ax          
    jmp read_loop

print_reverse:
    lea dx, msg2
    mov ah, 9
    int 21h

print_loop:
    cmp sp, 100h
    je done
    pop ax
    mov dl, al
    mov ah, 2
    int 21h
    jmp print_loop

done:
    mov ah, 4ch
    int 21h

main endp
end main