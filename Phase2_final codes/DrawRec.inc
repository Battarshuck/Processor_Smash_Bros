DrawRec MACRO x,y ;x y top left corner of the drawn rectangle
    local loop1,loop2
     
  
  mov cx,x
  mov dx,y
  
  
  mov al,0fh
  mov ah,0ch
  mov bx,25 ;length  ;joe old 40
  
  
  loop1:
  int 10h
  add cx,60
  int 10h
  sub cx,60
  inc dx
  dec bx
  cmp bx,0
  jnz loop1
  
    
  mov cx,x
  mov dx,y
  mov bx,60 ;width
  
  
  loop2:
  int 10h
  add dx,25   ;joe old 40
  int 10h
  sub dx,25   ;joe old 40
  inc cx
  dec bx
  cmp bx,0
  jnz loop2  
           
  
    


    
ENDM DisplayString