DrawObj1 Macro xcm,NumPos

    ;mov xcm,60
    mov ycm,175
    mov r,10
    mov clr,0Eh
    DrawCir xcm,ycm,xc,yc,p,r,clr
     mov ah,2
     
     ;mov dl,7   ;X-position
     mov dl,NumPos   ;X-position
     mov dh,12   ;Y-position
     int 10h      
     mov ah,9
     mov dx,offset LFallObjY1
     int 21h
    add xcm,40
    mov clr,4
    DrawCir xcm,ycm,xc,yc,p,r,clr
    mov ah,2
    add NumPos,5
    mov dl,NumPos
     ;mov dl,12   ;X-position
     mov dh,12   ;Y-position
     int 10h      
     mov ah,9
     mov dx,offset LFallObjR1
     int 21h
    add xcm,40
    mov clr,0ah
    DrawCir xcm,ycm,xc,yc,p,r,clr
    mov ah,2
    add NumPos,5
    mov dl,NumPos
    ;mov dl,17   ;X-position
    mov dh,12   ;Y-position
    int 10h      
    mov ah,9
    mov dx,offset LFallObjG1
    int 21h
    add xcm,40
    mov clr,0Dh
 
    DrawCir xcm,ycm,xc,yc,p,r,clr
    mov ah,2
    add NumPos,5
    mov dl,NumPos
     ;mov dl,22   ;X-position
     mov dh,12   ;Y-position
     int 10h      
     mov ah,9
     mov dx,offset LFallObjP1
     int 21h

endm DrawObj1

DrawObj2 Macro xcm,NumPos

    ;mov xcm,60
    mov ycm,175
    mov r,10
    mov clr,0Eh
    DrawCir xcm,ycm,xc,yc,p,r,clr
     mov ah,2
     
     ;mov dl,7   ;X-position
     mov dl,NumPos   ;X-position
     mov dh,12   ;Y-position
     int 10h      
     mov ah,9
     mov bl,0EFh
     mov dx,offset LFallObjY2
     int 21h
    add xcm,40
    mov clr,4
    DrawCir xcm,ycm,xc,yc,p,r,clr
    mov ah,2
    add NumPos,5
    mov dl,NumPos
     ;mov dl,12   ;X-position
     mov dh,12   ;Y-position
     int 10h      
     mov ah,9
     mov dx,offset LFallObjR2
     int 21h
    add xcm,40
    mov clr,0ah
    DrawCir xcm,ycm,xc,yc,p,r,clr
    mov ah,2
    add NumPos,5
    mov dl,NumPos
    ;mov dl,17   ;X-position
    mov dh,12   ;Y-position
    int 10h      
    mov ah,9
    mov dx,offset LFallObjG2
    int 21h
    add xcm,40
    mov clr,0Dh
 
    DrawCir xcm,ycm,xc,yc,p,r,clr
    mov ah,2
    add NumPos,5
    mov dl,NumPos
     ;mov dl,22   ;X-position
     mov dh,12   ;Y-position
     int 10h      
     mov ah,9
     mov dx,offset LFallObjP2
     int 21h

endm DrawObj2