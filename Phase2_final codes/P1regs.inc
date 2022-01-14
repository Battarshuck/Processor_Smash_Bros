P1regs MACRO 
    
    mov ah,2
    mov dl,1   ;X-position
    mov dh,0   ;Y-position
    int 10h
    mov ah,9
    mov dx,offset user_name+2
    int 21h


    mov ah,2
    mov dl,1   ;X-position
    mov dh,4   ;Y-position
    int 10h
    mov ah,9
    mov dx,offset P2_FrbdnChar+2
    int 21h
    
    mov xr,60

    mov yr,25  ;joe old:10
  
    DrawRec xr,yr
  
    add yr,28  ;joe old:40
    DrawRec xr,yr

    add yr,28  ;joe old:40

    DrawRec xr,yr
    
    add yr,28  ;joe old:40
    DrawRec xr,yr

    mov xr,125 ;joe old:120
    mov yr,25  ;joe old:10
    DrawRec xr,yr
    
    add yr,28  ;joe old:40
    DrawRec xr,yr
    
    add yr,28  ;joe old:40
    DrawRec xr,yr
    
    add yr,28  ;joe old:40
    DrawRec xr,yr

     mov ah,2
     mov dl,5   ;X-position
     mov dh,2   ;Y-position
     int 10h      
     mov ah,9
     mov dx,offset Lax
     int 21h

    mov ah,2
    mov dl,5    ;X-position
    mov dh,4    ;Y-position
    int 10h  
    mov ah,9
    mov dx,offset Lbx
    int 21h

    mov ah,2
    mov dl,5    ;X-position
    mov dh,6    ;Y-position
    int 10h  
    mov ah,9
    mov dx,offset Lcx
    int 21h


    mov ah,2
    mov dl,5    ;X-position
    mov dh,8    ;Y-position
    int 10h  
    mov ah,9
    mov dx,offset Ldx
    int 21h

    mov ah,2
    mov dl,24   ;X-position
    mov dh,2    ;Y-position
    int 10h  
    mov ah,9
    mov dx,offset Lsi
    int 21h

    mov ah,2
    mov dl,24   ;X-position
    mov dh,4    ;Y-position
    int 10h  
    mov ah,9
    mov dx,offset Ldi
    int 21h
    
    mov ah,2
    mov dl,24   ;X-position
    mov dh,6    ;Y-position
    int 10h  
    mov ah,9
    mov dx,offset Lsp
    int 21h

    mov ah,2
    mov dl,24   ;X-position
    mov dh,8    ;Y-position
    int 10h  
    mov ah,9
    mov dx,offset Lbp
    int 21h

    ;Resgisters values-----------------
    mov ah,2
    mov dl,9   ;X-position
    mov dh,2   ;Y-position
    int 10h      
    mov ah,9
    mov dx,offset P1_regs[0]
    int 21h

    mov ah,2
    mov dl,9    ;X-position
    mov dh,4    ;Y-position
    int 10h  
    mov ah,9
    mov dx,offset P1_regs[5]
    int 21h

    mov ah,2
    mov dl,9    ;X-position
    mov dh,6    ;Y-position
    int 10h  
    mov ah,9
    mov dx,offset P1_regs[10]
    int 21h


    mov ah,2
    mov dl,9    ;X-position
    mov dh,8    ;Y-position
    int 10h  
    mov ah,9
    mov dx,offset P1_regs[15]
    int 21h

    mov ah,2
    mov dl,17   ;X-position
    mov dh,2    ;Y-position
    int 10h  
    mov ah,9
    mov dx,offset P1_regs[20]
    int 21h

    mov ah,2
    mov dl,17   ;X-position
    mov dh,4    ;Y-position
    int 10h  
    mov ah,9
    mov dx,offset P1_regs[25]
    int 21h
    
    mov ah,2
    mov dl,17   ;X-position
    mov dh,6    ;Y-position
    int 10h  
    mov ah,9
    mov dx,offset P1_regs[30]
    int 21h

    mov ah,2
    mov dl,17   ;X-position
    mov dh,8    ;Y-position
    int 10h  
    mov ah,9
    mov dx,offset P1_regs[35]
    int 21h

ENDM P1regs