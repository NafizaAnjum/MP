.model small
.stack 100h
.data
    buffer db 20          ; max chars
           db ?           ; will hold length
           db 20 dup(0)   ; input chars
    msg db 10,13,'Enter string (max 20 chars): $'
    result_msg db 10,13,'First character: $'
.code
main proc
    mov ax, @data
    mov ds, ax
    
    ; prompt
    lea dx, msg
    mov ah, 9
    int 21h
    
    ; read string
    lea dx, buffer
    mov ah, 0Ah
    int 21h
    
    ; print result message on new line
    lea dx, result_msg
    mov ah, 9
    int 21h
    
    ; print first char
    mov dl, [buffer+2]
    mov ah, 2
    int 21h
    
    ; print final newline
    mov ah, 2
    mov dl, 10
    int 21h
    mov dl, 13
    int 21h
    
    ; exit
    mov ah, 4Ch
    int 21h
main endp
end main