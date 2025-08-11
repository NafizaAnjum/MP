.model small
.stack 100h

.data
    myString db 'Hello, World!$'

.code
main:
    mov ax, @data      ; Load address of data segment
    mov ds, ax         ; Initialize DS with data segment address

    lea dx, myString   ; Load offset address of string
    mov ah, 09h              ; Function to display string
    int 21h                  ; DOS interrupt

    mov ah, 4Ch              ; Exit function
    int 21h

end main
