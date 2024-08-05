data segment 
msg1 db 'Enter a number: $'
maxSize dw 6 ;max size of the number 
numSize dw 0  ; number size
numSizeStr db 2 dup ('$') ; number size string
sum dw 0 ; sum storage 
msgDigits db 'The number of digits is: $'
msgReverse db 'The reverse number is: $'
data ends
code segment
assume cs:code ,ds:data
start: 
    mov ax, data
    mov ds, ax
    mov cx,maxSize ;max size of the number 
    mov dx, offset msg1 ;print msg to enter a number
    mov ah, 9   
    int 21h

    mov dl, 10 ;print new line
    mov ah, 2
    int 21h

    mov di,offset numSize ;number size
    mov si,offset sum ;sum storage
readnumber:
    mov ah, 1 ; read a number
    int 21h
    cmp al, 0Dh ; check if enter was pressed
    je done_reading
    sub al, '0' ; convert to number
    add [si], al ; add to sum
    inc byte ptr [di] ; increment number size
    push ax  ; push the number to the stack for reverse when pop
    loop readnumber
    
done_reading:
    mov ax,numSize ;number size
    add al, '0' ;convert to ascii
    mov numSizeStr, al ;store in numSizeStr

    mov dl, 10 ;print new line
    mov ah, 2
    int 21h

    int 21h
    mov dx,offset msgdigits ;print msgDigits to enter a number
    mov ah, 9
    int 21h

    mov dx,offset numSizeStr ;print number size to enter a number
    mov ah, 9
    int 21h

    mov dl, 10 ;print new line
    mov ah, 2
    int 21h
    
    int 21h
    mov dx,offset msgReverse ;print msgDigits to enter a number
    mov ah, 9
    int 21h

    mov cx,numSize ;number size for loop reverse
popReverse:
    cmp cx,0 ;check if done
    je done
    pop ax ;pop the number from the stack
    add al, '0' ;convert to ascii
    mov dl,al ;store in dl and print
    mov ah, 2
    int 21h
    loop popReverse

done:
    mov ah,4Ch
    int 21h
code ends
end start