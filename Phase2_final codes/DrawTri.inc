DrawTri MACRO x,y,clr
local loop1,loop2,loop3
mov cx,x
mov dx,y
  
  
mov al,clr
mov ah,0ch

mov bx,20
loop1:int 10h
inc CX
inc DX
int 10h
dec bx
cmp bx,0
jnz loop1
mov cx,x
mov dx,y
mov bx,20
loop2:int 10h
dec CX
inc DX
int 10h
dec bx
cmp bx,0
jnz loop2
mov bx,40
loop3:int 10h
inc CX
int 10h
dec bx
cmp bx,0
jnz loop3
endm DrawTri