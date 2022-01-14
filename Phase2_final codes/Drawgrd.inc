Drawgrd macro ;splits the screen
    local loop1, loop2,loop33
    mov al,03h
    mov ah,0ch

    mov cx,320
    mov dx,0
    loop1: ;split screen into 2 players' screen
    int 10h
    inc dx
    cmp dx,230 ;joe
    jnz loop1

    mov cx,0  ;split for bottons bel 3ard
    mov dx,230  ;joe
    loop2:
    int 10h
    inc cx
    cmp cx,640
    jnz loop2
    
    mov cx,0  ;Draw Chat Bar
    mov dx,300
    loop33:
    int 10h
    inc cx
    cmp cx,640
    jnz loop33


endm