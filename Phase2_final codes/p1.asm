.model small
.stack 64

.data
VALUE db ?
Value2 db 7,?,7 dup('$')
col db 1
.code 

main proc far
    mov ax,@data
    mov DS,ax

	mov ah,0
	mov al,3
	int 10h

call port_initializing



chatloop:
		; MOV AH, 01H
    	; INT 16H     ;;;GetKeyPress
    	; JZ KeyNotPressed
    	; MOV AH, 00H
    	; INT 16H      ;WaitKeyPress
    	; mov value,al
		; jmp AGAIN

;Check that Data is Ready
		mov dx , 3FDH		; Line Status Register
		in al , dx 
  		test al , 1
  		JZ CHK                                    ;Not Ready
 ;If Ready read the VALUE in Receive data register
  		mov dx , 03F8H
  		in al , dx 
  		mov VALUE , al

		mov ah,2
   		mov dl,VALUE
    	int 21h  ;printing  
		CHK:


    MOV AH, 01H
    INT 16H     ;;;GetKeyPress
    JZ KeyNotPressed
    MOV AH, 00H
    INT 16H      ;WaitKeyPress
    mov value,al
	jmp AGAIN
;Check that Transmitter Holding Register is Empty
	 AGAIN:	mov dx , 3FDH		; Line Status Register
  		In al , dx 			;Read Line Status
  		test al , 00100000b
  		JZ AGAIN                               ;Not empty

;If empty put the VALUE in Transmit data register
  		mov dx , 3F8H		; Transmit data register
		  
       	mov al,value
		out dx , al
       
		MOV AH, 01H
    	INT 16H     ;;;GetKeyPress
		JZ KeyNotPressed
    	MOV AH, 00H
    	INT 16H      ;WaitKeyPress
    	mov value,al
		jmp AGAIN

	   KeyNotPressed:
		;flushing keyboard buffer
        mov ah,0ch
        mov al,0
        int 21h



jmp chatloop

hlt
main endp 

port_initializing proc near

mov dx,3fbh 			; Line Control Register
mov al,10000000b		;Set Divisor Latch Access Bit
out dx,al				;Out it

mov dx,3f8h			
mov al,0ch			
out dx,al

mov dx,3f9h
mov al,00h
out dx,al

mov dx,3fbh
mov al,00011011b
out dx,al


ret
port_initializing endp

end main
