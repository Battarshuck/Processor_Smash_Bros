include Print.inc
.model small
.386
.data
RecMess db ?
SentMess db ?
.stack 64

.code

Main proc Far
mov dx,3fbh 			; Line Control Register
mov al,10000000b		;Set Divisor Latch Access Bit
out dx,al		
mov dx,3f8h			
mov al,0ch			
out dx,al
mov dx,3f9h
mov al,00h
out dx,al
mov dx,3fbh
mov al,00011011b
out dx,al

mov ax,0600h
mov bh,07
mov cx,0000
mov dx,184FH
int 10h  ;clearing whole screen

SetCursor 0,0

KeepChatting:
MOV AH, 01H
INT 16H     ;;;GetKeyPress
JZ KeyNotPressed
MOV AH, 00H
INT 16H      ;WaitKeyPress
KeyNotPressed:
JZ Recieving
MOV SentMess, AL
call send   

Recieving:
call receive
popf
JZ checkESC
mov ah,2
mov dl,RecMess
int 21h
checkESC:
mov ah,0
int 16h     ;getting key pressed from the buffer
cmp AL,27d  ;checking if user pressed 'Enter'
jz continueGame
jmp KeepChatting
continueGame:
ret
Main endp



send proc near
;Check that Transmitter Holding Register is Empty
	
        mov dx , 3FDH		; Line Status Register
        In al , dx 			;Read Line Status
  		test al , 00100000b
  		JZ AGAIN                               ;Not empty

;If empty put the VALUE in Transmit data register
  		mov dx , 3F8H ; Transmit data register
  		mov al,SentMess
        out dx , al
    
AGAIN:
  		
ret
send endp

receive proc near
;Check that Data is Ready
		; mov cx,3
        ; mov si,0
        ; loop333:
        mov dx,3FDH		; Line Status Register
	    in al,dx 
  		test al,1
  		JZ CHK                                  ;Not Ready
 ;If Ready read the VALUE in Receive data register
  		mov dx , 03F8H
  		in al , dx
  		mov RecMess,al
     CHK:
        ; inc si
        ; dec cx
        ; cmp cx,0
        ; jnz loop333
        pushf
ret
receive endp

end Main