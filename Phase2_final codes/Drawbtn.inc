Drawbtncommand MACRO x,y ;x y top left corner of the drawn rectangle
    local loop1,loop2
     
  
  mov cx,x
  mov dx,y
  
  
  mov al,0Fh
  mov ah,0ch
  mov bx,28
  
  
  loop1:
  int 10h
  add cx,58
  int 10h
  sub cx,58
  inc dx
  dec bx
  cmp bx,0
  jnz loop1
  
    
  mov cx,x
  mov dx,y
  mov bx,58
  
  
  loop2:
  int 10h
  add dx,28
  int 10h
  sub dx,28
  inc cx
  dec bx
  cmp bx,0
  jnz loop2  

    
ENDM Drawbtncommand

DrawDSbtn MACRO x,y ;x y top left corner of the drawn rectangle
    local loop1111,loop222


  mov cx,x
  mov dx,y


  mov al,0Fh
  mov ah,0ch
  mov bx,28


  loop1111:
  int 10h
  add cx,65
  int 10h
  sub cx,65
  inc dx
  dec bx
  cmp bx,0
  jnz loop1111


  mov cx,x
  mov dx,y
  mov bx,65


  loop222:
  int 10h
  add dx,28
  int 10h
  sub dx,28
  inc cx
  dec bx
  cmp bx,0
  jnz loop222


ENDM DrawDSbtn





