DrawDS MACRO
    local loop11,loop22,local3,local4
    mov al,03h
    mov ah,0ch
    
    mov cx,260
    mov dx,0
    loop11: 
    int 10h
    inc dx
    cmp dx,230  ;joe
    jnz loop11
    
    mov cx,639
    mov dx,0

    loop13: ;split screen into 2 players' screen
    int 10h
    inc dx
    cmp dx,230  ;joe
    jnz loop13

    mov cx,579
    mov dx,0
    loop22:
    int 10h
    inc dx
    cmp dx,230  ;joe
    jnz loop22
    
    mov cx,260
    mov dx,0
    loop3:
    int 10h
    inc cx
    cmp cx,320
    jnz loop3
    add dx,26   ;joe old:25
    mov cx,260
    cmp dx,230  ;joe
    jb loop3
    
    mov cx,579
    mov dx,0
    loop4:
    int 10h
    inc cx
    cmp cx,639
    jnz loop4
    add dx,26  ;joe old:25
    mov cx,579
    cmp dx,230  ;joe
    jb loop4

ENDM DrawDS