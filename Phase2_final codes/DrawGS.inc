DrawDS MACRO
    
    mov al,03h
    mov ah,0ch
    mov cx,260
    mov dx,0
    loop11: ;split screen into 2 players' screen
    int 10h
    inc dx
    cmp dx,200
    jnz loop11
    mov cx,580
    mov dx,0
    loop22: ;split screen into 2 players' screen
    int 10h
    inc dx
    cmp dx,200
    jnz loop22

ENDM DrawDS
