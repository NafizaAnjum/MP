.model small
.stack 100h

.data
    even_msg db 'Number is EVEN.$'
    odd_msg  db 'Number is ODD.$'

.code
main proc
    mov ax, @data
    mov ds, ax

    mov ah, 1
    int 21h
    sub al, '0'

    test al, 1
    jz print_even

print_odd:
    lea dx, odd_msg
    mov ah, 9
    int 21h
    jmp done

print_even:
    lea dx, even_msg
    mov ah, 9
    int 21h

done:
    mov ah, 4ch
    int 21h

main endp
end main