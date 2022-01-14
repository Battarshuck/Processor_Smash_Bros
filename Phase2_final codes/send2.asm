setcursorchat  MACRO x,y

	mov ah,2
	mov dl,x
	mov dh,y
	int 10h

ENDM setcursorchat


checkinput  MACRO x,y,char
    local key_enter,key_backspace,exit_checkinput,key_esc,skip_backspace


	cmp char,13d
    jz key_enter

    cmp char,8
    jz key_backspace

	cmp char,27d
	jz key_esc

    jmp exit_checkinput



    key_enter:
    inc y
    mov x,0
	mov inc_flag,1
	

    jmp exit_checkinput
	;-------------------------------------------------------------

    key_backspace:
	cmp x,0
	jz skip_backspace
    dec x

	setcursorchat x,y
	mov ah,2
   	mov dl,32d
    int 21h  ;printing blank space  

	skip_backspace:

	mov inc_flag,1

	jmp exit_checkinput
	
	key_esc:
	mov exit_flag,1

    exit_checkinput:

ENDM checkinput



.model small
.386
.stack 64

.data
VALUE   db ?
user1_x db 0
user1_y db 2

user2_x db 0
user2_y db 15

inc_flag  db 0
exit_flag db 0

.code 

main proc far
    mov ax,@data
    mov DS,ax

	mov ah,0
	mov al,3
	int 10h

	call DrawChatSpliter

	call port_initializing



chatloop:


 	mov ah, 01h
    int 16h     ;;;GetKeyPress
    jz noletter

    mov ah, 00h
    int 16h      ;WaitKeyPress
    mov VALUE,al


    checkinput user1_x,user1_y,VALUE
    setcursorchat user1_x,user1_y

	cmp exit_flag,1
    jz exit_chat

	mov ah,2
   	mov dl,VALUE
    int 21h  ;printing  

   

	cmp inc_flag,1
	jz skip_inc1
		
    inc user1_x

	skip_inc1:
    
	mov inc_flag,0
;----------------------------------------------------------------------------------
;----------------------------------------------------------------------------------
;Check that Transmitter Holding Register is Empty
	 AGAIN:	mov dx , 3FDH		; Line Status Register
  		In al , dx 			;Read Line Status
  		test al , 00100000b
  		JZ AGAIN                               ;Not empty

;If empty put the VALUE in Transmit data register
  		mov dx , 3F8H		; Transmit data register
		  
       	mov al,value
		out dx , al
       
	   noletter:
        call CheckScroll 

        ;Check that Data is Ready
		mov dx , 3FDH		; Line Status Register
		in al , dx 
  		test al , 1
  		JZ chatloop                                    ;Not Ready
 ;If Ready read the VALUE in Receive data register
  		mov dx , 03F8H
  		in al , dx 
  		mov VALUE , al
;----------------------------------------------------------------------------------
;----------------------------------------------------------------------------------
		

        checkinput user2_x,user2_y,VALUE
        setcursorchat user2_x,user2_y

        cmp exit_flag,1
		jz exit_chat

		mov ah,2
   		mov dl,VALUE
    	int 21h  ;printing  

		cmp inc_flag,1
		jz skip_inc2

        inc user2_x

		skip_inc2:

		mov inc_flag,0   
		call CheckScroll 

jmp chatloop

exit_chat:

hlt
ret
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


DrawChatSpliter proc near
	pusha
	
	setcursorchat 0,12

    mov ah,9
    mov bh,0
    mov al,2dh
    mov cx, 80d
    mov bl,0fh
	int 10h

	popa

ret
DrawChatSpliter endp


CheckScroll proc near
	pusha

	cmp user1_y,10d
	jb skip_user1_scroll

	mov ax,0601h
	mov bh,07h
	mov cl,0
	mov ch,2
	mov dl,80d
	mov dh,11d
	int 10h

	dec user1_y

	skip_user1_scroll:

	cmp user2_y,23d
	jb exit_checkscroll

	mov ax,0601h
	mov bh,07h
	mov cl,0
	mov ch,15
	mov dl,80d
	mov dh,25d
	int 10h

	dec user2_y

	exit_checkscroll:
	popa
ret
CheckScroll endp

end main
