P2regs MACRO
    
    mov ah,2
    mov dl,42   ;X-position
    mov dh,0   ;Y-position
    int 10h
    mov ah,9
    mov dx,offset user2_name+2
    int 21h

    mov ah,2
    mov dl,42   ;X-position
    mov dh,4   ;Y-position
    int 10h
    mov ah,9
    mov dx,offset P1_FrbdnChar+2
    int 21h

    mov xr,380
    mov yr,25  ;joe old:10
    
    DrawRec xr,yr
    
    add yr,28  ;joe old:40
    DrawRec xr,yr
    
    add yr,28  ;joe old:40
    DrawRec xr,yr
    add yr,28  ;joe old:40
    DrawRec xr,yr

    add xr,65
     mov yr,25  ;joe old:10
    DrawRec xr,yr
    add yr,28  ;joe old:40
    DrawRec xr,yr
    add yr,28  ;joe old:40
    DrawRec xr,yr
    add yr,28  ;joe old:40
    DrawRec xr,yr

    mov ah,2
    mov dl,44   ;X-position
    mov dh,2    ;Y-position
    int 10h      
    mov ah,9
    mov dx,offset Lax
    int 21h

    mov ah,2
    mov dl,44   ;X-position
    mov dh,4    ;Y-position
    int 10h  
    mov ah,9
    mov dx,offset Lbx
    int 21h

    mov ah,2
    mov dl,44   ;X-position
    mov dh,6    ;Y-position
    int 10h  
    mov ah,9
    mov dx,offset Lcx
    int 21h


    mov ah,2
    mov dl,44   ;X-position
    mov dh,8    ;Y-position
    int 10h  
    mov ah,9
    mov dx,offset Ldx
    int 21h

    mov ah,2
    mov dl,64   ;X-position
    mov dh,2    ;Y-position
    int 10h  
    mov ah,9
    mov dx,offset Lsi
    int 21h

    mov ah,2
    mov dl,64   ;X-position
    mov dh,4    ;Y-position
    int 10h  
    mov ah,9
    mov dx,offset Ldi
    int 21h
    
    mov ah,2
    mov dl,64   ;X-position
    mov dh,6    ;Y-position
    int 10h  
    mov ah,9
    mov dx,offset Lsp
    int 21h

    mov ah,2
    mov dl,64   ;X-position
    mov dh,8    ;Y-position
    int 10h  
    mov ah,9
    mov dx,offset Lbp
    int 21h

    ;Resgisters values-----------------

    mov ah,2
    mov dl,49   ;X-position
    mov dh,2    ;Y-position
    int 10h      
    mov ah,9
    mov dx,offset P2_regs[0]
    int 21h

    mov ah,2
    mov dl,49   ;X-position
    mov dh,4    ;Y-position
    int 10h  
    mov ah,9
    mov dx,offset P2_regs[5]
    int 21h

    mov ah,2
    mov dl,49   ;X-position
    mov dh,6    ;Y-position
    int 10h  
    mov ah,9
    mov dx,offset P2_regs[10]
    int 21h


    mov ah,2
    mov dl,49   ;X-position
    mov dh,8    ;Y-position
    int 10h  
    mov ah,9
    mov dx,offset P2_regs[15]
    int 21h

    mov ah,2
    mov dl,57   ;X-position
    mov dh,2    ;Y-position
    int 10h  
    mov ah,9
    mov dx,offset P2_regs[20]
    int 21h

    mov ah,2
    mov dl,57   ;X-position
    mov dh,4    ;Y-position
    int 10h  
    mov ah,9
    mov dx,offset P2_regs[25]
    int 21h
    
    mov ah,2
    mov dl,57   ;X-position
    mov dh,6    ;Y-position
    int 10h  
    mov ah,9
    mov dx,offset P2_regs[30]
    int 21h

    mov ah,2
    mov dl,57   ;X-position
    mov dh,8    ;Y-position
    int 10h  
    mov ah,9
    mov dx,offset P2_regs[35]
    int 21h

ENDM P2regs