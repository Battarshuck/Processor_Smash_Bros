
DrawRectangleReg MACRO x,y ;x y top left corner of the drawn rectangle
    local loop1,loop2
     
  mov ah,0
  mov al,13h
  int 10h
  
  
  mov cx,x
  mov dx,y
  
  
  mov al,0Fh
  mov ah,0ch
  mov bx,25
  
  
  loop1:
  int 10h
  add cx,50
  int 10h
  sub cx,50
  inc dx
  dec bx
  cmp bx,0
  jnz loop1
  
    
  mov cx,x
  mov dx,y
  mov bx,50
  
  
  loop2:
  int 10h
  add dx,25
  int 10h
  sub dx,25
  inc cx
  dec bx
  cmp bx,0
  jnz loop2  
           
  
    


    
ENDM DisplayString