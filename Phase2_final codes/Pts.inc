UpdatePoints MACRO 

    mov ah,2
    mov dl,15 ;X
    mov dh,0 ;Y
    int 10h      
    mov ah,9
    mov dx,offset P1_init_points+2
    int 21h

    mov ah,2
    mov dl,55 ;x
    mov dh,0  ;y
    int 10h      
    mov ah,9
    mov dx,offset P2_init_points+2
    int 21h

ENDM UpdatePoints

IncrementPoints MACRO pnum,value ;;player number, value to increment p1 or p2
    local exit_incpoints,incpoints_p2

    cmp pnum,2
    jz incpoints_p2

    mov al,2
    convrt_string_hex P1_init_points,al
    add cx,value
    mov ax,cx

    call Convrt_Hex_String

    mov cx,2
    mov si,offset num_placeholder+2
    mov di,offset P1_init_points+2
    rep movsb   

    jmp exit_incpoints

    ;------------------------------------------

    incpoints_p2:

    mov al,2
    convrt_string_hex P2_init_points,al
    add cx,value
    mov ax,cx

    call Convrt_Hex_String

    mov cx,2
    mov si,offset num_placeholder+2
    mov di,offset P2_init_points+2
    rep movsb   

    exit_incpoints:

ENDM IncrementPoints


DecrementPoints MACRO pnum,value
    local exit_incpoints,incpoints_p2

    cmp pnum,2
    jz incpoints_p2

    mov al,2
    convrt_string_hex P1_init_points,al
    sub cx,value
    mov ax,cx
    
    call Convrt_Hex_String

    mov cx,2
    mov si,offset num_placeholder+2
    mov di,offset P1_init_points+2
    rep movsb   

    jmp exit_incpoints

    ;------------------------------------------

    incpoints_p2:

    mov al,2
    convrt_string_hex P2_init_points,al
    sub cx,value
    mov ax,cx

    call Convrt_Hex_String

    mov cx,2
    mov si,offset num_placeholder+2
    mov di,offset P2_init_points+2
    rep movsb   

    exit_incpoints:

ENDM DecrementPoints