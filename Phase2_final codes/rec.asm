.model small
.data
VALUE db 3 dup(?),'$'
indata db 30,?,30 dup('$')
;db '$'
cnt equ 3
.code
main proc far
mov ax,@Data
mov ds,ax
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
call rec
mov dx,offset VALUE
mov ah,9
int 21h
mov ah,0Ah
mov dx,offset indata
int 21h
call send

    mov ah,0
    int 16h     ;getting key pressed from the buffer
    cmp AL,27d  ;checking if user pressed 'Enter'
    jz contiune
    mov ah,0ch
    mov al,0
    int 21h     ;flushing keyboard buffer
    jmp Enter_Loop


contiune:

;mov ah,02
;mov dl,VALUE
;int 21h


main endp

rec proc near
;Check that Data is Ready
		mov cx,3
        mov si,0
        loop3:
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
        jnz loop3
ret
rec endp

send proc near
;Check that Transmitter Holding Register is Empty
		mov cl,3
        mov si,2
        loop4:
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
        jnz loop4

  		
ret
send endp


end main