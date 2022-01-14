.model small
.data
mes db 'a'
VALUE db 3 dup(?),'$'
indata db 30,?,30 dup('$')
.code
main proc far

mov AX,@Data
mov DS,AX

; mov ah,0Ah
; mov dx,offset indata
; int 21h

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

Enter_Loop:

mov ah,0Ah
mov dx,offset indata
int 21h
call send
call rec
mov dx,offset VALUE
    mov ah,9
    int 21h

    mov ah,0
    int 16h     ;getting key pressed from the buffer
    cmp AL,27d  ;checking if user pressed 'esc'
    jz contiune
    mov ah,0ch
    mov al,0
    int 21h     ;flushing keyboard buffer
    jmp Enter_Loop


contiune:

main endp

send proc near
;Check that Transmitter Holding Register is Empty
		mov cl,3
        mov si,2
        loop1:
        mov dx , 3FDH		; Line Status Register
AGAIN:  	In al , dx 			;Read Line Status
  		test al , 00100000b
  		JZ AGAIN                               ;Not empty

;If empty put the VALUE in Transmit data register
  		mov dx , 3F8H ; Transmit data register
  		mov al,indata[si]
        inc si  
        dec cl
        out dx , al
        cmp cl,0
        jnz loop1

  		
ret
send endp
rec proc near
;Check that Data is Ready
		mov cx,3
        mov si,0
        loop2:
        mov dx , 3FDH		; Line Status Register
	CHK:	in al , dx 
  		test al , 1
  		JZ CHK                                    ;Not Ready
 ;If Ready read the VALUE in Receive data register
  		mov dx , 03F8H
        
          
  		in al , dx
  		mov VALUE[si],al
        inc si
        dec cx
        cmp cx,0
        jnz loop2
ret
rec endp

end main