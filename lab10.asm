.model small
.stack 100h
.data
msg1 db 'Enter marks (0-100): $'
gradeAplus db 0Dh,0Ah, 'Grade = A+ $'
gradeA db 0Dh,0Ah, 'Grade = A $'
gradeB db 0Dh,0Ah, 'Grade = B $'
gradeC db 0Dh,0Ah, 'Grade = C $'

.code
main proc
    mov ax,@data
    mov ds,ax

    ; Prompt user
    lea dx, msg1
    mov ah, 09h
    int 21h

    ; Read first digit
    mov ah, 01h
    int 21h
    sub al, '0'
    mov bl, al      ; tens digit

    ; Read second digit
    mov ah, 01h
    int 21h

    cmp al, 0Dh     ; check if Enter key (user input one digit only)
    je one_digit_input
    sub al, '0'
    mov bh, al      ; ones digit
    jmp combine

one_digit_input:
    mov bh, 0       ; if only one digit entered, ones = 0

combine:
    mov al, bl
    mov cl, 10
    mul cl          ; al = tens * 10
    add al, bh      ; al = total marks
    mov bl, al

    ; Compare marks and print grade
    cmp bl, 80
    jae grade_Aplus

    cmp bl, 70
    jae grade_A

    cmp bl, 60
    jae grade_B

    jmp grade_C

grade_Aplus:
    lea dx, gradeAplus
    mov ah, 09h
    int 21h
    jmp done

grade_A:
    lea dx, gradeA
    mov ah, 09h
    int 21h
    jmp done

grade_B:
    lea dx, gradeB
    mov ah, 09h
    int 21h
    jmp done

grade_C:
    lea dx, gradeC
    mov ah, 09h
    int 21h

done:
    mov ah, 4Ch
    int 21h
main endp
end main
