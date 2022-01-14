;Setting cursor position
SetCursor MACRO x,y

    mov bh,0
    mov ah,2
    mov dl,x
    mov dh,y
    int 10h

ENDM SetCursor

;Displaying messages
ShowMessage MACRO MyMessage

    mov ah,9h
    mov dx,offset MyMessage
    int 21h

ENDM ShowMessage