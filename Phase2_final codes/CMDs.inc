ResetPlaceholder MACRO

;ALWAYS RESET THE PLACEHOLDER
mov si,offset zeros_placeholder
mov di,offset num_placeholder

mov cx,4
repe movsb

ENDM ResetPlaceholder


convrt_string_hex MACRO STR,mode 
    local exit,letter1,letter2,letter3,letter4,continue1,continue2,continue3,continue4
    ;Starting from least to most significant digits
    ;mn el yemeen L el shemal ya fala7een ya3ny
    
    ;INSTRUCTIONS: 
    ;RESULT-->CX
    ;if you want to use it for AL
    ;Then when call mode=2, STR=offset AX 3ady gedan
    ;----------------
    ;BUT for AH
    ;Then when call mode=2, !!!STR=offset AX-2!!!
    ;minus 2 lama te3melaha call tab3an msh hena ya alby              
    
    ;First digit
    
    mov cx,0
    mov di,offset STR
    mov cl,[di+3]
    cmp cl,41h
    
    jae letter1
    
    sub cl,30h
    jmp continue1
    
    letter1: 
    sub cl,37h
    
    continue1:

    cmp mode,3
    jz exit
    ;------------------
    ;Second digit
    mov al,[di+2]
    mov ah,0
    cmp al,41h
    jae letter2 
    
    sub al,30h
    jmp continue2
    
    letter2:
    sub al,37h
    
    
    continue2:
    
    mov bl,10h
    mul bx 
    
    add al,cl
    mov cl,al 
    
    
    cmp mode,2
    jz exit
    
    ;-----------------
    ;Third digit
    mov al,[di+1]
    mov ah,0
   
    cmp al,41h
    jae letter3 
    
    sub al,30h
    jmp continue3
    
    letter3:
    sub al,37h
    
    
    continue3:
    
    
    mov dx,0
    mov bx,100h
    mul bx 
    
    add ax,cx
    mov cx,ax
    
    ;---------------- 
    ;Fourth digit
    mov al,[di]
    mov ah,0
    cmp al,41h
    
    jae letter4 
    
    sub al,30h
    jmp continue4
    letter4:
    sub al,37h
    
    
    continue4:
     
    
    mov dx,0
    mov bx,1000h
    mul bx
    
    add ax,cx
    mov cx,ax
    
    exit:
    mov ax,0
    
    
ENDM convrt_string_hex
