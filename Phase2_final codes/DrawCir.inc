DrawCir Macro xcm,ycm,xc,yc,p,r,clr
local loop100,JUMP1,JUMP2,JUMP3,JUMP4,STOP
;plot the center
        mov ah,0ch
        mov al,clr
     
        ;draw circle using (midpoint algorithm)
        ;y=r
        mov ax,r 
        mov yc,ax
        
        ;plot initial point
        Plot xcm,ycm,xc,yc,clr
        ;p=1-r
        mov ax,01
        mov dx,r
        xor dx,0ffffh
        inc dx
        add ax,dx
        mov p,ax
        
        ;while(x<y) 
    loop100:  mov ax,xc
        cmp ax,yc
        jnc stop
        
        ;x++
        inc xc
        
        ;if(p<0)
        mov ax,p
        rcl ax,01
        jnc jump2
        
        ;p+=2*x+1
        mov ax,xc
        rcl ax,01
        inc ax
        add ax,p
        jmp jump3
        
        ;else
        ;y++
        ;p+=2*(x-y)+1;
    jump2:  dec yc
        mov ax,xc
        mov dx,yc
        xor dx,0ffffh
        inc dx
        add ax,dx
        rcl ax,01
        jnc jump4
        or ax,8000h
    jump4: inc ax
        add ax,p
        
    jump3:  mov p,ax
        ;plot point
        Plot xcm,ycm,xc,yc,clr
        jmp loop100

        
    stop:
        mov xc,0
        mov yc,0
        mov P,0
endm


Plot Macro xcm,ycm,xc,yc,clr
mov ah,0ch
    mov al,clr
                
    mov cx,xcm
    add cx,xc
    mov dx,ycm
    add dx,yc
    int 10h
        
    mov cx,xcm
    add cx,xc
    mov dx,ycm
    sub dx,yc
    int 10h

        mov cx,xcm
        sub cx,xc
        mov dx,ycm
        add dx,yc
        int 10h
        
        mov cx,xcm
        sub cx,xc
        mov dx,ycm
        sub dx,yc
        int 10h
        
        mov cx,xcm
        add cx,yc
        mov dx,ycm
        add dx,xc
        int 10h
        
        mov cx,xcm
        add cx,yc
        mov dx,ycm
        sub dx,xc
        int 10h
        
        mov cx,xcm
        sub cx,yc
        mov dx,ycm
        add dx,xc
        int 10h
        
        mov cx,xcm
        sub cx,yc
        mov dx,ycm
        sub dx,xc
        int 10h

endm

