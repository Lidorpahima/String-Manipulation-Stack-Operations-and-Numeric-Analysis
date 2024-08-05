data segment 
str1 db 's',1,'c',4,'e',4,'b',2,'s',2
size1 db 10
str2 db 20h dup(?)
size2 db 13
data ends
code segment
assume cs:code ,ds:data
start: 
    mov ax,data
    mov ds,ax
    mov bx,offset str1 ;insert str 1 to bx
    mov cx,offset size1 ;insert size to cx
    shr cx,1 ;divine in 2 because the char and number of times
    inc cx ;inc cx because later in start with -1 in the readStr1 loop
    mov si,offset str2 ;insert str2 to si
    
readStr1: ;will used to read str1 and will insert to str2
    dec cx 
    cmp cx,0  ;compare if we copied all the string
    je done
    mov al,[bx];save the char for str2 will use later
    inc bx
    push cx ;save the loop and go for inside loop
    mov cl,byte ptr[bx] ;get the inside loop for how many time we have to insert the char into str2
    jmp insertstr2


insertstr2:;will used for insert to str2 
    cmp cx,0
    je nextChar ;if inserted all the char will move for next char
    cmp cx,20
    mov byte ptr [si],al;add the char for str 2
    inc si
    loop insertstr2;loop until all the chars copied
nextChar:
    pop cx ;pop the outside loop for next char
    inc bx;+1 for bx and move for next char in str1 string
    jmp readstr1
done:
    mov byte ptr[si],'$';end of the str2 string
    mov dx,offset str2;insert str2 string to dx to print
    mov ah,9
    int 21h

    mov ah,4Ch
    int 21h
code ends
end start