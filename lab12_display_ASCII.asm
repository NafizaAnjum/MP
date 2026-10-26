.model small
.stack 100h
.code

main:
    mov ah, 02h        ; DOS function to display character
    mov bx, 32         ; Start from ASCII 32

display_loop:
    mov dl, bl         ; Load lower byte of BX into DL
    int 21h            ; Display character
    inc bx             ; Move to next character
    cmp bx, 256        ; Stop when BX reaches 256
    jl display_loop    ; Loop while BX < 256

    ; Exit program
    mov ah, 4Ch
    int 21h

end main
