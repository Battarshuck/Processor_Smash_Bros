DrawFcr Macro xcm,ycm,xc,yc,p,r,clr
local fill
fill:
     DrawCir xcm,ycm,xc,yc,p,r,clr
    dec r
    cmp r,0
    jnz fill
    mov r,10
endm