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
include DrawRec.inc
include DrawCir.inc
include DrawFcr.inc
include DrawDS.inc
include Drawbtn.inc
include Drawgrd.inc
include DrawTri.inc
include DrawObj.inc
include CMDs.inc
include Valid.inc
include Ops.inc
include Pts.inc
include Print.inc
include cmpchar.inc
include Chckend.inc
include BtnAct.inc

.model small
.stack 64
.386
.data

;---------------MAIN MENU DATA---------------------------------------------
;X & Y positions
point_x                     db ?
point_y                     db ?

;user info
user_name                  db 17,?, 17 dup('$')
user2_name                  db 17,?, 17 dup('$')

P1_init_points              db 3,?,2  dup('0'),'$','$'
P2_init_points              db 3,?,2  dup('0'),'$','$'
P1_FrbdnChar                db 2,?,2  dup('?'),'$','$'
P2_FrbdnChar                db 2,?,2  dup('?'),'$','$'
frbdncharflg                db 0

points_inc_value            dw ? ;points incrementation value
points_inc_index            db ? ;Player1-->1 && Player2-->2
;Chatting Variables
RecMess db 12 dup(?),'$'
SentMess db 30,?,30 dup('$')

;Messages strings
user_name_message           db 'Enter User 1 Name:',10,13,'$'
user2_name_message          db 10,13,'Enter User 2 Name:',10,13,'$'
user1_FrbdnChar             db 10,13,'Enter Player 1 forbidden Character:',10,13,'$'
user2_FrbdnChar             db 10,13,'Enter Player 2 forbidden Character:',10,13,'$'
user_init_points_message    db 10,13,'Enter Initial Points:',10,13,'$'
main_menu_continue_message  db 10,13,'Press Enter to contiune$'
press_F1_message            db 'Press [F1] to start chatting mode $'
press_F2_message            db 'Press [F2] to game mode $'
press_ESC_message           db 'Press [ESC] to exit program $'
;----------------------------------------------------------------
choose_Level1_message       db '[1] Beginners level$'
choose_Level2_message       db '[2] Beast level$'
press_level_choice          db 'Choose 1 or 2 to start an unforgettable game!$'
commandString               db 10  dup('$')
resetcmdStr                 db 10  dup('$')
cmndStringLength            dw 0

xr dw ?
yr dw ?
 
x db ?
y db ?
;;circle related variables
xcm dw ? ;circle midpoint
ycm dw ? ;circle midpoint
xc dw 0
yc dw 0
r dw 5
p dw 0
clr db ?
;triangle coordinates
x1 dw ?
y1 dw ?
;Object Coordinates
xo dw ?
yo dw ?
ro dw 10
clro db ?

;command

btn_num           dw ?
num_placeholder   db "0000$"
zeros_placeholder db "0000$"
Player_turn       dw 1
Player_num        db ? ; used to know which player register will change
RegToBeUpdated    db ? ; register number that will be updated for the player
AddrToBeUpdated   db ? ; data segment address number that will be updated for the player
OpBtn             dw ?
;commands operands
operand1 dw 0000
operand2 dw 0000
operand1_btn db ?
operand2_btn db ?
Temp_Mul dw ?
mode db 1
;Registers labels--------------------
Lax      db "AX$"
Lbx      db "BX$"
Lcx      db "CX$"
Ldx      db "DX$"
Lsi      db "SI$"
Ldi      db "DI$"
Lsp      db "SP$"
Lbp      db "BP$"
Lah      db "AH$"
Lal      db "AL$"
Lbh      db "BH$"
Lbl      db "BL$"
Lch      db "CH$"
Lcl      db "CL$"
Ldh      db "DH$"
Ldl      db "DL$"
Limd_adr db "VAL$"
Ldir_adr db "[VL]$"
Lind_adr db "[BX]$"
Lbas_adr db "[BX+V]$"

;;Falling Objects Data
LFallObjY1 db '0$'
LFallObjR1 db '0$'
LFallObjG1 db '0$'
LFallObjP1 db '0$'
LFallObjY2 db '0$'
LFallObjR2 db '0$'
LFallObjG2 db '0$'
LFallObjP2 db '0$'
NumPos db ?
;Registers and Data Segment values---------------------
;           AX[0]   BX[5]   CX[10]  DX[15]  SI[20]  DI[25]  SP[30]  BP[35]
P1_regs db "0000$","0000$","0000$","0000$","0000$","0000$","0000$","0000$"

;           AX[0]   BX[5]   CX[10]  DX[15]  SI[20]  DI[25]  SP[30]  BP[35]
P2_regs db "0000$","0000$","0000$","0000$","0000$","0000$","0000$","0000$"

;           [0]   [3]   [6]   [9]   [12]  [15]  [18]  [21]  [24]
P1_ds   db "00$","00$","00$","00$","00$","00$","00$","00$","00$"

;           [0]   [3]   [6]   [9]   [12]  [15]  [18]  [21]  [24]
P2_ds   db "00$","00$","00$","00$","00$","00$","00$","00$","00$"


;-----------------------------
DS_labels db "0$","1$","2$","3$","4$","5$","6$","7$","8$"
db "$$$"
trycatch db "0000$"
 
;command buttons lables------------------
Ladd  db "ADD$"
Ladc  db "ADC$"
Lsub  db "SUB$"
Lsbb  db "SBB$"
Ldiv  db "DIV$"
Lmul  db "MUL$"
Lxor  db "XOR$"
Land  db "AND$"
Lor   db "OR$"
Lnop  db "NOP$";---------new_row----------
Lshr  db "SHR$"
Lshl  db "SHL$"
Lmov  db "MOV$"
Linc  db "INC$"
Ldec  db "DEC$"
Lclc  db "CLC$"
Lidiv db "IDIV$"
Limul db "IMUL$"
Lror  db "ROR$"
Lrol  db "ROL$"
tes   db "testbtn$"
;User string-------------------
ReadUserSTR                db 5,?,5 dup('0'),'0'
ReadUserSTR_frbdn          db 8 dup('$'),'$','$'
ReadUserSTR_frbdn_Size     dw ?
ReadUserSTR_type           db ?
ReadUserSTR_syntaxErroFlag db 0  ;0 for no error, 1 for error, RESET FOR USER AFTER HIS TURN HAS ENDED
Valid_input                db '0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F'

;power ups---------------------
flagpower1_own             db 0
flagpower2_ownandopponent  db 0

flagpower3_changefbdn_p1   db 0 ;can only be used once by a player
flagpower3_changefbdn_p2   db 0 ;can only be used once by a player

;flagpower4_stuckbit        db 0 ;value to be used is in CX
power4_stuckbitvalue       dw ?
power4_stuckbitvalue2       dw ?
power4_stuckbitindex        dw ?
power4_stuckbitindex2       dw ?
flagpower4_stuckbit_p1     db 0
flagpower4_stuckbit_p2     db 0


flagpower5_regclr_p1       db 0
flagpower5_regclr_p2       db 0


powerup_error              db 0

Player1_win_message         db 'PLAYER 1 IS THE WINNER!$'
Player2_win_message         db 'PLAYER 2 IS THE WINNER!$'

;--------------------------------------------
;END GAME
endgame_value db "105E$"
Player_win    db 0 ;1 for player1, 2 for player2
reserve       dw ?

;-----------------------------------------

;temps
get_datasegment_address   dw ?
get_datasegment_mode      db ?
temp1                     db ? ; used in get value from data segment
player_points             dw ? ;used in power ups
temp_reg_num              db ? ;used in power ups
tempFrbd                  dw ?
tempPW                    dw ?
p_num                     db ?
reg_num                   db ?
address                   db ?
getP2info                 db 0
getp1info                 db 0
;------------------CHAT-----------------;
VALUE   db ?
user1_x db 0
user1_y db 2

user2_x db 0
user2_y db 15

inc_flag  db 0
exit_flag db 0

;;;;;;;;;;;;;;;DS;;;;;
DSAdd             db ? ; Data segment address used for setting address
operand1_btn_DS db ?
operand2_btn_DS db ?
modeDS db ?
temp_DS                   dw ?
;;LEVEL 2::::
Level                     db ?

.code

Main proc far
mov ax,@data
mov ds,ax
mov es,ax

mov ah,0
mov al,3h
int 10h   ;opening text mode

call port_initializing

;Taking Input----------------------------------------
; ShowMessage user_name_message ;displaying user_name_message

; mov ah,0Ah
; mov dx,offset user_name
; int 21h   ;taking user name

ShowMessage user2_name_message ;displaying user_name_message

mov ah,0Ah
mov dx,offset user2_name
int 21h   ;taking user2 name

; ShowMessage user_init_points_message  ;displaying user_init_points_message


; mov ah,0Ah
; mov dx,offset P1_init_points
; int 21h   ;taking user intitial points

ShowMessage user_init_points_message  ;displaying user_init_points_message


mov ah,0Ah
mov dx,offset P2_init_points
int 21h   ;taking user intitial points

gobacktoMAINscreen:
ShowMessage main_menu_continue_message ;displaying main_menu_continue_message
;------------------------------------------------
;call AssignSmallestPts ;choosing the lowest points

Enter_Loop:
    mov ah,0
    int 16h     ;getting key pressed from the buffer
    cmp AL,13d  ;checking if user pressed 'Enter'
    jz contiune
    mov ah,0ch
    mov al,0
    int 21h     ;flushing keyboard buffer
    jmp Enter_Loop


contiune: ;continue program
;Main Menu
mov ax,0600h
mov bh,07
mov cx,0000
mov dx,184FH
int 10h  ;clearing whole screen


call CreateMainMenu

;--------------------------------------------


mov ah,0
int 16h

cmp ah,3bh ;if the user pressed F1
jz RunChat

cmp ah,3ch ;if the user pressed F2
jz RunGame

cmp ah,01h ;used pressed ESC
jz endgame

RunChat:
; mov ax,0600h
; mov bh,07
; mov cx,0000
; mov dx,184FH
; int 10h  ;clearing whole screen
; pusha
mov getp2info,1
pusha
call sendP2info
call sendPTS
;call sendP2frbdn
call sendName
popa
waitforp11:
cmp getp1info,1
jz gotp1data1
pusha
call receivep1info
popa
jmp waitforp11
gotp1data1:
pusha
call receivePTS
;call receivep1frbdn
call receiveName
popa


call Chat

jmp gobacktoMAINscreen

RunGame:
mov ax,0600h
mov bh,07
mov cx,0000
mov dx,184FH
int 10h  ;clearing whole screen

call ChooseFrbdn
mov getp2info,1
pusha
call sendP2info
call sendPTS
call sendP2frbdn
call sendName
popa
waitforp1:
cmp getp1info,1
jz gotp1data
pusha
call receivep1info
popa
jmp waitforp1
gotp1data:
pusha
call receivePTS
call receivep1frbdn
call receiveName
call receiveLvl
popa
call AssignSmallestPts

call PlayGame

jmp gobacktoMAINscreen
exit_main:

endgame:
mov ax,0600h
mov bh,07
mov cx,0000
mov dx,184FH
int 10h  ;clearing whole screen
mov ah,4ch ;To end/terminate the program
int 21h

Main endp

Chat proc NEAR
mov ah,0
	mov al,3
	int 10h

call DrawChatSpliter
call port_initializing
pusha
SetCursor 0,0
ShowMessage user2_name+2
setcursor 0,14
ShowMessage user_name+2
popa


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
	 AGAIN6:	mov dx , 3FDH		; Line Status Register
  		In al , dx 			;Read Line Status
  		test al , 00100000b
  		JZ AGAIN6                               ;Not empty

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
chat endp

PlayGame proc near
    mov ax,@data
    mov ds,ax
    mov es,ax
    mov ah,0
    mov al,10h  ;;10h 640x350
    int 10h
    
    ;Drawing lines(grid)
    Drawgrd
    ;Drawing Commands buttons
    call DrawCommandRow
    ;DrawAddressingRow

    ;Drawing Registers
    call Update_P1ds
    call Update_P2ds
    call P1regs
    call P2regs
    DrawDS
    UpdatePoints

    ;call Gun
    
    Start_Again:

    waityourturn:
    cmp Player_turn,2
    jz yourturn
    pusha
    call receiveTurn
    popa
    cmp Player_turn,3
    jz randomFlyingObj
    jmp waityourturn
    yourturn:
    call receivePTS
    call receiveReg
    ;pusha
    ;
    ;popa
    ;call P2regs
    ;call UpdateRegValue
    pusha
    CheckEndGame
    popa
    ;-------------------------------------------------------------
    ;checking wining flag
    cmp Player_win,1
    jz Finish
    cmp Player_win,2
    jz  Finish

    ;-------------------------------------------------------------


    jmp skiprandomFlyingObj
    randomFlyingObj:
    mov Player_turn,2
    call Gun
    mov Player_turn,1
    jmp waityourturn
    skiprandomFlyingObj:

    MOV AH, 00h  ; interrupts to get system time
    int 1AH      ; CX:DX now hold number of clock ticks since midnight
    mov  ax, dx
    xor  dx, dx
    mov  cx, 2d
    div  cx       ;here dx contains the remainder of the division - from 0 to 3
    cmp dx,1
    jz randomFlyingObj1
    jmp skiprandomFlyingObj1
    randomFlyingObj1:
    mov Player_turn,3
    call sendTurn
    mov Player_turn,2
    call Gun
    mov Player_turn,2
    skiprandomFlyingObj1:

    
    ;call Gun
    call P1regs
    call P2regs
    UpdatePoints
    call Pwrups
    UpdatePoints
    Drawgrd
    call P1regs
    call P2regs
    call DrawCommandRow
    ; mov xcm,60
    ; mov NumPos,7
    ; DrawObj1 xcm,NumPos
    mov xcm,380
    mov NumPos,47
    DrawObj2 xcm,NumPos

    mov ax,1
    int 33h
    GameLoop:;============================================

    UpdatePoints

    call Getbtnclicked

    cmp ax, 0ffffh
    jnz RegAddMenu
    jz GameLoop
    RegAddMenu:

    BtnAct
    call Update_P1ds
    call Update_P2ds
    call P1regs
    call p2regs

  

    mov ReadUserSTR_syntaxErroFlag,0
    cmp Player_turn,2
    je chng_turn
    jmp chng_turn2
    chng_turn:
    mov Player_turn,1
    call sendTurn
    call sendPTS
    call sendReg
    pusha
    CheckEndGame
    popa
    ;checking wining flag
    cmp Player_win,1
    jz Finish
    cmp Player_win,2
    jz  Finish
    
    jmp Start_Again
    chng_turn2:
    mov Player_turn,2
    call sendTurn
    call sendPTS
    call sendReg
    pusha
    CheckEndGame
    popa
    ;checking wining flag
    cmp Player_win,1
    jz Finish
    cmp Player_win,2
    jz  Finish
    
    jmp Start_Again
    Finish:


    mov ah,0
    mov al,3h
    int 10h   ;opening text mode

    mov point_x,32d
    mov point_y,10d

    SetCursor point_x,point_y

    mov ax,0600h
    mov bh,07
    mov cx,0000
    mov dx,184FH
    int 10h  ;clearing whole screen


    cmp Player_win,2
    jz player2_winmessage

    ShowMessage Player1_win_message

    jmp skip_win

    player2_winmessage:

    ShowMessage Player2_win_message

    skip_win:

    Enter_Loop2:
    mov ah,0
    int 16h     ;getting key pressed from the buffer
    cmp AL,13d  ;checking if user pressed 'Enter'
    jz contiune
    mov ah,0ch
    mov al,0
    int 21h     ;flushing keyboard buffer
    jmp Enter_Loop2
    mov Player_win,0
    hlt
    ret
playGame endp
;-----------MAIN MENU PROCEDURES----------------

CreateMainMenu PROC NEAR

mov point_x,32d
mov point_y,10d

SetCursor point_x,point_y

ShowMessage press_F1_message
;----------------------------------------
mov point_x,32d
mov point_y,12d

SetCursor point_x,point_y

ShowMessage press_F2_message
;----------------------------------------
mov point_x,32d
mov point_y,14d

SetCursor point_x,point_y

ShowMessage press_ESC_message
;----------------------------------------

ret
CreateMainMenu ENDP


;Taking lowest points and assigning it to both users
AssignSmallestPts PROC NEAR

cmp P1_init_points+1,2
jnz assign_1num111
mov dl,2
convrt_string_hex P1_init_points,dl
jmp skip_assign11

assign_1num111:
mov dl,3
convrt_string_hex P1_init_points-1,dl
skip_assign11:

mov ax,cx

;--------------------------------------------------
push ax
cmp P2_init_points+1,2
jnz assign_1num22
mov dl,2
convrt_string_hex P2_init_points,dl
jmp skip_assign22

assign_1num22:
mov dl,3
convrt_string_hex P2_init_points-1,dl
skip_assign22:

pop ax
mov bx,cx

mov cx,2
;ax-> Pts1, bx->Pts2
cmp ax,bx
ja assign_pts2

mov si,offset P1_init_points+2
mov di,offset P2_init_points+2
repe movsb

jmp exit_assign

assign_pts2:;player2 has the lowest points

mov si,offset P2_init_points+2
mov di,offset P1_init_points+2
repe movsb

exit_assign:
ret
AssignSmallestPts ENDP

;---------------------------------------------
;---------------------------------------------
 
Getbtnclicked proc near
 
    noleftclick:
            mov ax,0003h
            int 33h ;CX(X), DX(Y)
            test bx,1
            jz noleftclick ;break if user clicked the left click
 
    mov bx,dx
    mov dx,0
    mov ax,cx
    mov cx,64 ;58 is the btn width
    div cx    ;integer division
 
    cmp bx,230
    ja under
 
    mov ax,0ffffh
    jmp exit
 
    under:
        cmp bx,265
        jb row_0
 
        cmp bx,300
        jb row_10
 
        mov ax,0ffffh
        jmp exit
 
        row_0:
            add ax,0
            jmp exit
 
        row_10:
            add ax,10d
 
 
    exit:
 
    mov btn_num,ax
    ret
Getbtnclicked endp

;-----------------------------------------------------

GetNumFromUser proc near

    ;clearing buttons area---
    mov ax,0600h
    mov bh,0
    mov cl,0  ;x1
    mov ch,17 ;y1
    mov dl,80 ;x2
    mov dh,20 ;y2
    int 10h

    ;setting cursor position-----
    mov ah,2
    mov dl,3
    mov dh,17
    int 10h

    ;Reading string-----
    mov ah,0ah
    mov dx,offset ReadUserSTR
    int 21h

    ;Capitalize every letter entered (if exist)
    ;and check for bad input, if syntax error ---> jmp exit_user
    mov dl,[ReadUserSTR+1]
    Valid_user_syntaxError ReadUserSTR+2,dl ;sending the string, and its actual size

    cmp ReadUserSTR_syntaxErroFlag,1
    jz exit_user
    push cx
    mov SI,offset ReadUserSTR+2
    mov DI,offset ReadUserSTR_frbdn
    mov ch,0
    mov cl,ReadUserSTR+1
    rep MOVSB
    mov Cl,ReadUserSTR+1
    mov ReadUserSTR_frbdn_Size,Cx
    pop cx
    ;Checking how many digits the user entered
    cmp ReadUserSTR+1,4
    jz user_16bit_4digit
    cmp ReadUserSTR+1,3
    jz user_16bit_3digit
    cmp ReadUserSTR+1,2
    jz user_8bit_2digit
    cmp ReadUserSTR+1,1
    jz user_8bit_1digit


    ;----------------------
    user_16bit_4digit:
    mov ReadUserSTR_type,1
    convrt_string_hex ReadUserSTR+2,ReadUserSTR_type
    jmp exit_user

    ;----------------------
    user_16bit_3digit:
    mov ReadUserSTR_type,1
    mov ReadUserSTR+1,0 ;moving zero to the actual size slot
    convrt_string_hex ReadUserSTR+1,ReadUserSTR_type
    jmp exit_user

    ;----------------------
    user_8bit_2digit:
    mov ReadUserSTR_type,2
    convrt_string_hex ReadUserSTR,ReadUserSTR_type
    jmp exit_user

    ;----------------------
    user_8bit_1digit:
    mov ReadUserSTR_type,2
    mov ReadUserSTR+1,0 ;moving zero to the actual size slot
    convrt_string_hex ReadUserSTR-1,ReadUserSTR_type


    exit_user:
    push cx

    ;clearing buttons area---
    mov ax,0600h
    mov bh,0
    mov cl,0  ;x1
    mov ch,17 ;y1
    mov dl,80 ;x2
    mov dh,20 ;y2
    int 10h

    pop cx

    ret
GetNumFromUser endp

ChooseFrbdn proc near

mov point_x,0d
mov point_y,0d

SetCursor point_x,point_y
; ShowMessage user1_FrbdnChar  ;displaying user_init_points_message


; mov ah,0Ah
; mov dx,offset P1_FrbdnChar
; int 21h   ;taking user intitial points
; cmp P1_FrbdnChar+2,61h
; jb skipcapital1
; sub P1_FrbdnChar+2,20h
; skipcapital1:

ShowMessage user2_FrbdnChar  ;displaying user_init_points_message


mov ah,0Ah
mov dx,offset P2_FrbdnChar
int 21h   ;taking user intitial points
cmp P2_FrbdnChar+2,61h
jb skipcapital2
sub P2_FrbdnChar+2,20h
skipcapital2:

ret
ChooseFrbdn endp

Gun proc near
 pusha
    cmp Player_turn,2
    jz gunp2
    jmp gunp1

    gunp1:
    mov x1,120
    mov y1,180
    jmp skipgunn
    gunp2:
    mov x1,440
    mov y1,180
    skipgunn:

    MOV AH, 00h  ; interrupts to get system time
    int 1AH      ; CX:DX now hold number of clock ticks since midnight
    mov  ax, dx
    xor  dx, dx
    mov  cx, 3d
    div  cx       ;here dx contains the remainder of the division - from 0 to 3
    cmp dx,0
    je yellow
    cmp dx,1
    je red
    cmp dx,2
    je green
    cmp dx,3
    je purble

    yellow:
    mov clro,0Eh
    jmp skipclr
    red:
    mov clro,04h
    jmp skipclr
    green:
    mov clro,0Ah
    jmp skipclr
    purble:
    mov clro,0Dh
    jmp skipclr
    skipclr:

    cmp Player_turn,1
    jz objpos1
    jmp objpos2

    objpos1:
    MOV AH, 00h  ; interrupts to get system time
    int 1AH      ; CX:DX now hold number of clock ticks since midnight
    mov  ax, dx
    xor  dx, dx
    mov  cx, 250d
    div  cx       ;here dx contains the remainder of the division - from 0 to 250
    cmp dx,10
    jb addpos
    jmp skipaddpos
    addpos:
    add dx,10
    skipaddpos:
    jmp skipobjpos

    objpos2:
    MOV AH, 00h  ; interrupts to get system time
    int 1AH      ; CX:DX now hold number of clock ticks since midnight
    mov  ax, dx
    xor  dx, dx
    mov  cx, 250d
    div  cx       ;here dx contains the remainder of the division - from 0 to 250
    cmp dx,10
    jb addpos1
    jmp skipaddpos1
    addpos1:
    add dx,10
    skipaddpos1:
    add dx,320

    skipobjpos:

    mov xo,dx ; random column
    ;mov xo,50
    mov yo,10
    mov ro,10
    ;mov clro,4h
    DrawCir xo,yo,xc,yc,p,ro,clro 

    loop1G: 
    DrawTri x1,y1,4 ;;GUN POSITION
    DrawCir xo,yo,xc,yc,p,ro,00
    inc yo
    cmp yo,220
    je Exit
    DrawCir xo,yo,xc,yc,p,ro,clro
    mov ah,1
    int 16h     ;getting key pressed from the buffer

    cmp Ah,77  ;checking if user pressed 'right'
    jz loop5G
    cmp ah,75  ;checking if user pressed 'left'
    jz loop2G
    cmp ah,72  ;checking if user pressed 'up'
    jz loop4G
    cmp ah,80 ;checking if user pressed 'down'
    jz loop3G
    cmp al,32 ;checking if user pressed 'spacebar'
    jz loop6G
    mov ah,0ch
    mov al,0
    int 21h
    hlt    ;flushing keyboard buffer
    jmp loop1G    

loop2G:
DrawTri x1,y1,0
sub x1,4
DrawTri x1,y1,4
mov ah,0ch
mov al,0
int 21h

hlt
jmp loop1G

loop3G:
DrawTri x1,y1,0
add y1,3
DrawTri x1,y1,4
mov ah,0ch
    mov al,0
    int 21h

hlt
jmp loop1G

loop4G:
DrawTri x1,y1,0
sub y1,3
DrawTri x1,y1,4
mov ah,0ch
    mov al,0
    int 21h

hlt
jmp loop1G

loop5G: 
DrawTri x1,y1,0
add x1,4
DrawTri x1,y1,4
mov ah,0ch
mov al,0
int 21h 

hlt
jmp loop1G


loop6G: ;for projectile

mov cx,x1
mov dx,y1

mov xcm,cx 
mov ycm,dx
mov r,3
mov clr,0Ah

repeatG:

DrawCir xcm,ycm,xc,yc,p,r,00 
dec ycm

DrawCir xcm,ycm,xc,yc,p,r,0Ah 
    
    
DrawCir xo,yo,xc,yc,p,ro,00
inc yo

DrawCir xo,yo,xc,yc,p,ro,clro 
mov ax,yo
cmp ycm,ax
jbe cmpcolumn
cmp ycm,5 ;;check the position of the projectile "must be edited for targets" ;; The Following 3 lines might be removed
hlt
jnz repeatG

jmp ExitG 

cmpcolumn:
mov ax,xcm ;;projectile
mov bx,xo ;;object
add bx,13

cmp ax,bx
jb cmpcolumn2
cmp ycm,5 ;;check the position of the projectile "must be edited for targets"
jz ExitG
cmp yo,220
jz Exit
hlt
jmp repeatG
cmpcolumn2:
sub bx,26
cmp ax,bx
ja Exit1G
cmp ycm,5 ;;check the position of the projectile "must be edited for targets"
jz ExitG
cmp yo,220
jz ExitG
hlt
jmp repeatG

Exit1G:;; add points to user IMP

; cmp Player_turn,1
; jz addptsp1
jmp addptsp2
; addptsp1:
; mov points_inc_index,1
; cmp clro,0Eh
; je incyellow
; cmp clro,04h
; je incred
; cmp clro,0Ah
; je incgreen
; cmp clro,0Dh
; je incpurble

; incyellow:
; mov points_inc_value,1
; IncrementPoints points_inc_index,points_inc_value
; mov Ah,LFallObjY1
; add Ah,30h
; inc AH
; sub Ah,30h
; mov LFallObjY1,ah
; jmp ExitG
; incred:
; mov points_inc_value,2
; IncrementPoints points_inc_index,points_inc_value
; mov Ah,LFallObjR1
; add Ah,30h
; inc AH
; sub Ah,30h
; mov LFallObjR1,ah
; jmp ExitG
; incgreen:
; mov points_inc_value,4
; IncrementPoints points_inc_index,points_inc_value
; mov Ah,LFallObjG1
; add Ah,30h
; inc AH
; sub Ah,30h
; mov LFallObjG1,ah
; jmp ExitG
; incpurble:
; mov points_inc_value,8
; IncrementPoints points_inc_index,points_inc_value
; mov Ah,LFallObjP1
; add Ah,30h
; inc AH
; sub Ah,30h
; mov LFallObjP1,ah
; jmp ExitG

; jmp skippaddpts

addptsp2:
mov points_inc_index,2
;skippaddpts:

cmp clro,0Eh
je incyellow1
cmp clro,04h
je incred1
cmp clro,0Ah
je incgreen1
cmp clro,0Dh
je incpurble1

incyellow1:
mov points_inc_value,1
IncrementPoints points_inc_index,points_inc_value
mov Ah,LFallObjY2
add Ah,30h
inc AH
sub Ah,30h
mov LFallObjY2,ah
jmp ExitG
incred1:
mov points_inc_value,2
IncrementPoints points_inc_index,points_inc_value
mov Ah,LFallObjR2
add Ah,30h
inc AH
sub Ah,30h
mov LFallObjR2,ah
jmp ExitG
incgreen1:
mov points_inc_value,4
IncrementPoints points_inc_index,points_inc_value
mov Ah,LFallObjG2
add Ah,30h
inc AH
sub Ah,30h
mov LFallObjG2,ah
jmp ExitG
incpurble1:
mov points_inc_value,8
IncrementPoints points_inc_index,points_inc_value
mov Ah,LFallObjP2
add Ah,30h
inc AH
sub Ah,30h
mov LFallObjP2,ah
jmp ExitG

ExitG:

DrawCir xcm,ycm,xc,yc,p,r,00
DrawCir xo,yo,xc,yc,p,ro,00
DrawTri x1,y1,00

mov ah,0ch
mov al,0
int 21h
popa
ret    
Gun endp

P1regs proc near 
    
    mov ah,2
    mov dl,1   ;X-position
    mov dh,0   ;Y-position
    int 10h
    mov ah,9
    mov dx,offset user_name+2
    int 21h

    mov ah,2
    mov dl,1   ;X-position
    mov dh,4   ;Y-position
    int 10h
    cmp Level,1
    je Show_FrbdnChar
    cmp Level,2
    je hide_FrbdnChar
    Show_FrbdnChar:
    mov ah,9
    mov dx,offset P2_FrbdnChar+2
    int 21h
    hide_FrbdnChar:
    
    mov xr,60

    mov yr,25  ;joe old:10
  
    DrawRec xr,yr
  
    add yr,28  ;joe old:40
    DrawRec xr,yr

    add yr,28  ;joe old:40

    DrawRec xr,yr
    
    add yr,28  ;joe old:40
    DrawRec xr,yr

    mov xr,125 ;joe old:120
    mov yr,25  ;joe old:10
    DrawRec xr,yr
    
    add yr,28  ;joe old:40
    DrawRec xr,yr
    
    add yr,28  ;joe old:40
    DrawRec xr,yr
    
    add yr,28  ;joe old:40
    DrawRec xr,yr

     mov ah,2
     mov dl,5   ;X-position
     mov dh,2   ;Y-position
     int 10h      
     mov ah,9
     mov dx,offset Lax
     int 21h

    mov ah,2
    mov dl,5    ;X-position
    mov dh,4    ;Y-position
    int 10h  
    mov ah,9
    mov dx,offset Lbx
    int 21h

    mov ah,2
    mov dl,5    ;X-position
    mov dh,6    ;Y-position
    int 10h  
    mov ah,9
    mov dx,offset Lcx
    int 21h


    mov ah,2
    mov dl,5    ;X-position
    mov dh,8    ;Y-position
    int 10h  
    mov ah,9
    mov dx,offset Ldx
    int 21h

    mov ah,2
    mov dl,24   ;X-position
    mov dh,2    ;Y-position
    int 10h  
    mov ah,9
    mov dx,offset Lsi
    int 21h

    mov ah,2
    mov dl,24   ;X-position
    mov dh,4    ;Y-position
    int 10h  
    mov ah,9
    mov dx,offset Ldi
    int 21h
    
    mov ah,2
    mov dl,24   ;X-position
    mov dh,6    ;Y-position
    int 10h  
    mov ah,9
    mov dx,offset Lsp
    int 21h

    mov ah,2
    mov dl,24   ;X-position
    mov dh,8    ;Y-position
    int 10h  
    mov ah,9
    mov dx,offset Lbp
    int 21h

    ;Resgisters values-----------------
    mov ah,2
    mov dl,9   ;X-position
    mov dh,2   ;Y-position
    int 10h      
    mov ah,9
    mov dx,offset P1_regs[0]
    int 21h

    mov ah,2
    mov dl,9    ;X-position
    mov dh,4    ;Y-position
    int 10h  
    mov ah,9
    mov dx,offset P1_regs[5]
    int 21h

    mov ah,2
    mov dl,9    ;X-position
    mov dh,6    ;Y-position
    int 10h  
    mov ah,9
    mov dx,offset P1_regs[10]
    int 21h


    mov ah,2
    mov dl,9    ;X-position
    mov dh,8    ;Y-position
    int 10h  
    mov ah,9
    mov dx,offset P1_regs[15]
    int 21h

    mov ah,2
    mov dl,17   ;X-position
    mov dh,2    ;Y-position
    int 10h  
    mov ah,9
    mov dx,offset P1_regs[20]
    int 21h

    mov ah,2
    mov dl,17   ;X-position
    mov dh,4    ;Y-position
    int 10h  
    mov ah,9
    mov dx,offset P1_regs[25]
    int 21h
    
    mov ah,2
    mov dl,17   ;X-position
    mov dh,6    ;Y-position
    int 10h  
    mov ah,9
    mov dx,offset P1_regs[30]
    int 21h

    mov ah,2
    mov dl,17   ;X-position
    mov dh,8    ;Y-position
    int 10h  
    mov ah,9
    mov dx,offset P1_regs[35]
    int 21h
ret
P1regs endp

P2regs proc near
    
    mov ah,2
    mov dl,42   ;X-position
    mov dh,0   ;Y-position
    int 10h
    mov ah,9
    mov dx,offset user2_name+2
    int 21h

   mov ah,2
    mov dl,42   ;X-position
    mov dh,4   ;Y-position
    int 10h
    cmp Level,1
    je Show_FrbdnChar2
    cmp Level,2
    je hide_FrbdnChar2
    Show_FrbdnChar2:
    mov ah,9
    mov dx,offset P1_FrbdnChar+2
    int 21h
    hide_FrbdnChar2:

    mov xr,380
    mov yr,25  ;joe old:10
    
    DrawRec xr,yr
    
    add yr,28  ;joe old:40
    DrawRec xr,yr
    
    add yr,28  ;joe old:40
    DrawRec xr,yr
    add yr,28  ;joe old:40
    DrawRec xr,yr

    add xr,65
     mov yr,25  ;joe old:10
    DrawRec xr,yr
    add yr,28  ;joe old:40
    DrawRec xr,yr
    add yr,28  ;joe old:40
    DrawRec xr,yr
    add yr,28  ;joe old:40
    DrawRec xr,yr

    mov ah,2
    mov dl,44   ;X-position
    mov dh,2    ;Y-position
    int 10h      
    mov ah,9
    mov dx,offset Lax
    int 21h

    mov ah,2
    mov dl,44   ;X-position
    mov dh,4    ;Y-position
    int 10h  
    mov ah,9
    mov dx,offset Lbx
    int 21h

    mov ah,2
    mov dl,44   ;X-position
    mov dh,6    ;Y-position
    int 10h  
    mov ah,9
    mov dx,offset Lcx
    int 21h


    mov ah,2
    mov dl,44   ;X-position
    mov dh,8    ;Y-position
    int 10h  
    mov ah,9
    mov dx,offset Ldx
    int 21h

    mov ah,2
    mov dl,64   ;X-position
    mov dh,2    ;Y-position
    int 10h  
    mov ah,9
    mov dx,offset Lsi
    int 21h

    mov ah,2
    mov dl,64   ;X-position
    mov dh,4    ;Y-position
    int 10h  
    mov ah,9
    mov dx,offset Ldi
    int 21h
    
    mov ah,2
    mov dl,64   ;X-position
    mov dh,6    ;Y-position
    int 10h  
    mov ah,9
    mov dx,offset Lsp
    int 21h

    mov ah,2
    mov dl,64   ;X-position
    mov dh,8    ;Y-position
    int 10h  
    mov ah,9
    mov dx,offset Lbp
    int 21h

    ;Resgisters values-----------------

    mov ah,2
    mov dl,49   ;X-position
    mov dh,2    ;Y-position
    int 10h      
    mov ah,9
    mov dx,offset P2_regs[0]
    int 21h

    mov ah,2
    mov dl,49   ;X-position
    mov dh,4    ;Y-position
    int 10h  
    mov ah,9
    mov dx,offset P2_regs[5]
    int 21h

    mov ah,2
    mov dl,49   ;X-position
    mov dh,6    ;Y-position
    int 10h  
    mov ah,9
    mov dx,offset P2_regs[10]
    int 21h


    mov ah,2
    mov dl,49   ;X-position
    mov dh,8    ;Y-position
    int 10h  
    mov ah,9
    mov dx,offset P2_regs[15]
    int 21h

    mov ah,2
    mov dl,57   ;X-position
    mov dh,2    ;Y-position
    int 10h  
    mov ah,9
    mov dx,offset P2_regs[20]
    int 21h

    mov ah,2
    mov dl,57   ;X-position
    mov dh,4    ;Y-position
    int 10h  
    mov ah,9
    mov dx,offset P2_regs[25]
    int 21h
    
    mov ah,2
    mov dl,57   ;X-position
    mov dh,6    ;Y-position
    int 10h  
    mov ah,9
    mov dx,offset P2_regs[30]
    int 21h

    mov ah,2
    mov dl,57   ;X-position
    mov dh,8    ;Y-position
    int 10h  
    mov ah,9
    mov dx,offset P2_regs[35]
    int 21h
ret
P2regs endp

Update_P1ds proc near
    
    ;Data Segment values-----------------
    mov ah,2
    mov dl,34   ;X-position
    mov dh,0   ;Y-position
    int 10h      
    mov ah,9
    mov dx,offset P1_ds[0]
    int 21h

    mov ah,2
    mov dl,34   ;X-position
    mov dh,2   ;Y-position
    int 10h  
    mov ah,9
    mov dx,offset P1_ds[3]
    int 21h

    mov ah,2
    mov dl,34    ;X-position
    mov dh,4    ;Y-position
    int 10h  
    mov ah,9
    mov dx,offset P1_ds[6]
    int 21h


    mov ah,2
    mov dl,34    ;X-position
    mov dh,6    ;Y-position
    int 10h  
    mov ah,9
    mov dx,offset P1_ds[9]
    int 21h

    mov ah,2
    mov dl,34   ;X-position
    mov dh,8d    ;Y-position
    int 10h  
    mov ah,9
    mov dx,offset P1_ds[12]
    int 21h

    mov ah,2
    mov dl,34   ;X-position
    mov dh,10d    ;Y-position
    int 10h  
    mov ah,9
    mov dx,offset P1_ds[15]
    int 21h
    
    mov ah,2
    mov dl,34   ;X-position
    mov dh,12d    ;Y-position
    int 10h  
    mov ah,9
    mov dx,offset P1_ds[18]
    int 21h

    mov ah,2
    mov dl,34   ;X-position
    mov dh,13d    ;Y-position
    int 10h  
    mov ah,9
    mov dx,offset P1_ds[21]
    int 21h

    mov ah,2
    mov dl,34   ;X-position
    mov dh,15d    ;Y-position
    int 10h  
    mov ah,9
    mov dx,offset P1_ds[24]
    int 21h



    ;Data Segment Lables-----------------
    mov ah,2
    mov dl,38   ;X-position
    mov dh,0   ;Y-position
    int 10h      
    mov ah,9
    mov dx,offset DS_labels[0]
    int 21h

    mov ah,2
    mov dl,38   ;X-position
    mov dh,2   ;Y-position
    int 10h  
    mov ah,9
    mov dx,offset DS_labels[2]
    int 21h

    mov ah,2
    mov dl,38    ;X-position
    mov dh,4    ;Y-position
    int 10h  
    mov ah,9
    mov dx,offset DS_labels[4]
    int 21h


    mov ah,2
    mov dl,38    ;X-position
    mov dh,6    ;Y-position
    int 10h  
    mov ah,9
    mov dx,offset DS_labels[6]
    int 21h

    mov ah,2
    mov dl,38   ;X-position
    mov dh,8d    ;Y-position
    int 10h  
    mov ah,9
    mov dx,offset DS_labels[8]
    int 21h

    mov ah,2
    mov dl,38   ;X-position
    mov dh,10d    ;Y-position
    int 10h  
    mov ah,9
    mov dx,offset DS_labels[10]
    int 21h
    
    mov ah,2
    mov dl,38   ;X-position
    mov dh,12d    ;Y-position
    int 10h  
    mov ah,9
    mov dx,offset DS_labels[12]
    int 21h

    mov ah,2
    mov dl,38   ;X-position
    mov dh,13d    ;Y-position
    int 10h  
    mov ah,9
    mov dx,offset DS_labels[14]
    int 21h

    mov ah,2
    mov dl,38   ;X-position
    mov dh,15d    ;Y-position
    int 10h  
    mov ah,9
    mov dx,offset DS_labels[16]
    int 21h

ret
Update_P1ds endp

Update_P2ds proc near
    
    ;Data Segment values-----------------
    mov ah,2
    mov dl,74   ;X-position
    mov dh,0   ;Y-position
    int 10h      
    mov ah,9
    mov dx,offset P2_ds[0]
    int 21h

    mov ah,2
    mov dl,74   ;X-position
    mov dh,2   ;Y-position
    int 10h  
    mov ah,9
    mov dx,offset P2_ds[3]
    int 21h

    mov ah,2
    mov dl,74    ;X-position
    mov dh,4    ;Y-position
    int 10h  
    mov ah,9
    mov dx,offset P2_ds[6]
    int 21h


    mov ah,2
    mov dl,74    ;X-position
    mov dh,6    ;Y-position
    int 10h  
    mov ah,9
    mov dx,offset P2_ds[9]
    int 21h

    mov ah,2
    mov dl,74   ;X-position
    mov dh,8d    ;Y-position
    int 10h  
    mov ah,9
    mov dx,offset P2_ds[12]
    int 21h

    mov ah,2
    mov dl,74   ;X-position
    mov dh,10d    ;Y-position
    int 10h  
    mov ah,9
    mov dx,offset P2_ds[15]
    int 21h
    
    mov ah,2
    mov dl,74   ;X-position
    mov dh,12d    ;Y-position
    int 10h  
    mov ah,9
    mov dx,offset P2_ds[18]
    int 21h

    mov ah,2
    mov dl,74   ;X-position
    mov dh,13d    ;Y-position
    int 10h  
    mov ah,9
    mov dx,offset P2_ds[21]
    int 21h

    mov ah,2
    mov dl,74   ;X-position
    mov dh,15d    ;Y-position
    int 10h  
    mov ah,9
    mov dx,offset P2_ds[24]
    int 21h



    ;Data Segment Lables-----------------
    mov ah,2
    mov dl,78   ;X-position
    mov dh,0   ;Y-position
    int 10h      
    mov ah,9
    mov dx,offset DS_labels[0]
    int 21h

    mov ah,2
    mov dl,78   ;X-position
    mov dh,2   ;Y-position
    int 10h  
    mov ah,9
    mov dx,offset DS_labels[2]
    int 21h

    mov ah,2
    mov dl,78    ;X-position
    mov dh,4    ;Y-position
    int 10h  
    mov ah,9
    mov dx,offset DS_labels[4]
    int 21h


    mov ah,2
    mov dl,78    ;X-position
    mov dh,6    ;Y-position
    int 10h  
    mov ah,9
    mov dx,offset DS_labels[6]
    int 21h

    mov ah,2
    mov dl,78   ;X-position
    mov dh,8d    ;Y-position
    int 10h  
    mov ah,9
    mov dx,offset DS_labels[8]
    int 21h

    mov ah,2
    mov dl,78   ;X-position
    mov dh,10d    ;Y-position
    int 10h  
    mov ah,9
    mov dx,offset DS_labels[10]
    int 21h
    
    mov ah,2
    mov dl,78   ;X-position
    mov dh,12d    ;Y-position
    int 10h  
    mov ah,9
    mov dx,offset DS_labels[12]
    int 21h

    mov ah,2
    mov dl,78   ;X-position
    mov dh,13d    ;Y-position
    int 10h  
    mov ah,9
    mov dx,offset DS_labels[14]
    int 21h

    mov ah,2
    mov dl,78   ;X-position
    mov dh,15d    ;Y-position
    int 10h  
    mov ah,9
    mov dx,offset DS_labels[16]
    int 21h

ret
Update_P2ds endp

Pwrups proc near
    
    ;push di
    ;push bx
    mov bh,0
    mov bx,Player_turn

    call GetNumFromUser

    push cx ;user chosen option

    cmp Player_turn,2
    jz player_2

    cmp P1_init_points+1,2
    jnz assign_1num1
    mov dl,2
    convrt_string_hex P1_init_points,dl
    jmp skip_p2

    assign_1num1:
    mov dl,3
    convrt_string_hex P1_init_points-1,dl

    jmp skip_p2
    ;----------------------------------------
    player_2:

    cmp P2_init_points+1,2
    jnz assign_1num222
    mov dl,2
    convrt_string_hex P2_init_points,dl
    jmp skip_p2

    assign_1num222:
    mov dl,3
    convrt_string_hex P2_init_points-1,dl

    skip_p2:
    ;-------------------------------

    mov player_points,cx
    pop cx

    ;!!!players points in temp2, chosen power up in cx!!!

    cmp cx,1
    jz powerup_1

    cmp cx,2
    jz powerup_2

    cmp cx,3
    jz powerup_3

    cmp cx,4
    jz powerup_4

    cmp cx,5
    jz powerup_5


    jmp exit_pwrups
    ;------------------------------------------
    powerup_1:

    cmp player_points,5
    jb exit_pwrups

    mov flagpower1_own,1
    mov bx,Player_turn
    mov bh,0
    mov points_inc_index,bl
    mov points_inc_value,5

    cmp level,2
    jz skipdec
    DecrementPoints points_inc_index,points_inc_value
    skipdec:

    jmp exit_pwrups



    ;-----------------------
    powerup_2:

    cmp player_points,3
    jb exit_pwrups
    mov bx,Player_turn
    mov bh,0
    mov points_inc_index,bl
    mov points_inc_value,3

    DecrementPoints points_inc_index,points_inc_value

    mov flagpower2_ownandopponent,1

    jmp exit_pwrups

    ;-----------------------
    
    powerup_3:
    
    cmp player_points,8
    jb exit_pwrups


    cmp Player_turn,2
    jz player2_check3

    cmp flagpower3_changefbdn_p1,1

    jz exit_pwrups

    ;PUT YOUR CODE HERE AMINOZ------------------------
  
    ;clearing buttons area---
    mov ax,0600h
    mov bh,0
    mov cl,0  ;x1
    mov ch,17 ;y1
    mov dl,80 ;x2
    mov dh,20 ;y2
    int 10h
    ;setting cursor position-----
    mov ah,2
    mov dl,3
    mov dh,17
    int 10h

    mov ah,0Ah
    mov dx,offset P1_FrbdnChar
    int 21h   ;taking user intitial points

    cmp P1_FrbdnChar+2,61h  
    jb skipcapital11
    sub P1_FrbdnChar+2,20h
    skipcapital11:
    ;-------------------------------------------------
    mov bx,Player_turn
    mov bh,0
    mov points_inc_index,bl
    mov points_inc_value,8

    DecrementPoints points_inc_index,points_inc_value

    mov flagpower3_changefbdn_p1,1
    jmp exit_pwrups


    player2_check3:

    cmp flagpower3_changefbdn_p2,1
    jz exit_pwrups
    ;PUT YOUR CODE HERE AMINOZ------------------------
    ;clearing buttons area---
    mov ax,0600h
    mov bh,0
    mov cl,0  ;x1
    mov ch,17 ;y1
    mov dl,80 ;x2
    mov dh,20 ;y2
    int 10h
    ;setting cursor position-----
    mov ah,2
    mov dl,3
    mov dh,17
    int 10h

    mov ah,0Ah
    mov dx,offset P2_FrbdnChar
    int 21h   ;taking user intitial points
    cmp P2_FrbdnChar+2,61h  
    jb skipcapital12
    sub P2_FrbdnChar+2,20h
    skipcapital12:

    ;-------------------------------------------------
    ;cmp flagpower3_changefbdn_p2,1
    mov bx,Player_turn
    mov bh,0
    mov points_inc_index,bl
    mov points_inc_value,8

    DecrementPoints points_inc_index,points_inc_value

    mov flagpower3_changefbdn_p2,1
    jz exit_pwrups


    ;-----------------------
    powerup_4: ;VALUE IS RETURNED IN DX, bit stuck type in power4_stuckbitvalue

    ;NOTE: if bit type = 0, yeb2a (Dx AND value) to force the bit to be zero
    ;      if bit type = 1, yeb2a (Dx OR value)  to force the bit to be one


    cmp player_points,2
    jb exit_pwrups

    call GetNumFromUser ;taking stuck bit value (0 or 1)
    mov power4_stuckbitvalue,cx
    call GetNumFromUser ;taking bit index (0-->15)
    mov power4_stuckbitindex,cx

    cmp power4_stuckbitvalue,1
    ja exit_pwrups

    cmp power4_stuckbitindex,15
    ja exit_pwrups

    mov dx,1
    push cx
    mov ch,0
    mov cx,power4_stuckbitindex
    shl dx,cl
    pop cx


    mov bx,Player_turn
    mov bh,0
    mov points_inc_index,bl
    mov points_inc_value,2

    DecrementPoints points_inc_index,points_inc_value

    cmp Player_turn,1
    jz pw4p1
    jmp pw4p2
    pw4p1:
    mov flagpower4_stuckbit_p1,1
    jmp skipppw4
    pw4p2:
    mov flagpower4_stuckbit_p2,1
    skipppw4:

    cmp power4_stuckbitvalue,1
    jz exit_pwrups
    not DX

    jmp exit_pwrups

    
    ;-------------------------------------


    powerup_5:
    ; push ax
    mov ax,0

    cmp player_points,30
    jb exit_pwrups

    cmp Player_turn,2
    jz player2_check5

    cmp flagpower5_regclr_p1,1
    jz exit_pwrups

    

    push bx
    mov bx,Player_turn
    mov p_num,bl
    pop bx
    mov reg_num,0
    call UpdateRegValue

    mov reg_num,1
    call UpdateRegValue

    mov reg_num,2
    call UpdateRegValue

    mov reg_num,3
    call UpdateRegValue

    mov reg_num,4
    call UpdateRegValue

    mov reg_num,5
    call UpdateRegValue

    mov reg_num,6
    call UpdateRegValue

    mov reg_num,7
    call UpdateRegValue

    mov bx,Player_turn
    mov bh,0
    mov points_inc_index,bl
    mov points_inc_value,30d

    DecrementPoints points_inc_index,points_inc_value

    mov flagpower3_changefbdn_p1,1

    ;pop ax
    jmp exit_pwrups


    player2_check5:

    cmp flagpower5_regclr_p2,1
    jz exit_pwrups
    
    push bx
    mov bx,Player_turn
    mov p_num,bl
    mov reg_num,0
    call UpdateRegValue
    pop bx

    mov reg_num,1
    call UpdateRegValue

    mov reg_num,2
    call UpdateRegValue

    mov reg_num,3
    call UpdateRegValue

    mov reg_num,4
    call UpdateRegValue

    mov reg_num,5
    call UpdateRegValue

    mov reg_num,6
    call UpdateRegValue

    mov reg_num,7
    call UpdateRegValue

    mov bx,Player_turn
    mov bh,0
    mov points_inc_index,bl
    mov points_inc_value,30
    

    DecrementPoints points_inc_index,points_inc_value

    mov flagpower5_regclr_p2,1
    
    ;pop ax
    jmp exit_pwrups



    exit_pwrups_error:
    mov powerup_error,1

    exit_pwrups:

    ;pop bx
    ;pop di
ret    
Pwrups endp

Pwrups_resetflag proc near 
    
    mov flagpower1_own,0
    mov flagpower2_ownandopponent,0
    ;mov flagpower4_stuckbit,0
ret
Pwrups_resetflag endp

Convrt_Hex_String proc near 
;local myloop,continue_convrt,exit_convrt,letter,continue,bit_0,bit_1,bit_2,bit_3
;output string will be in  num_placeholder variable
mov cl,0d
mov bx, 10h
myloop:
    mov dx,0
    div bx
    cmp dx,9h
    ja letter

    add dx,30h;if number add 30h
    inc cl
    jmp continue

    letter:;if letter add 37h
    add dx,37h
    inc cl
    jmp continue

    add ax,0
jnz myloop
jmp exit_convrt

continue:
    cmp cl,1
    jz bit_0

    cmp cl,2
    jz bit_1

    cmp cl,3
    jz bit_2

    cmp cl,4
    jz bit_3

    jmp exit_convrt

    bit_0:
        mov num_placeholder+3,dl
        jmp myloop 

    bit_1:
        mov num_placeholder+2,dl
        jmp myloop 

    bit_2:
        mov num_placeholder+1,dl
        jmp myloop 

    bit_3:
        mov num_placeholder+0,dl
        jmp myloop


exit_convrt:
ret
Convrt_Hex_String endp

UpdateRegValue proc near    
    call Convrt_Hex_String ;takes the new value from AX and converts it to string in num_placeholder variable
    
    mov si,offset num_placeholder

    cmp p_num,2
    jz PLAYER_2_REGS

    ;PLAYER-1 REGISTERS
    cmp reg_num,7
    ja Reg_byte_player1

    ;16-bit registers--------------------------------------------
    mov cx,4
    cmp reg_num,0
    jz reg_AX_p1

    cmp reg_num,1
    jz reg_BX_p1

    cmp reg_num,2
    jz reg_CX_p1

    cmp reg_num,3
    jz reg_DX_p1

    cmp reg_num,4
    jz reg_SI_p1

    cmp reg_num,5
    jz reg_DI_p1

    cmp reg_num,6
    jz reg_SP_p1

    cmp reg_num,7
    jz reg_BP_p1

    reg_AX_p1:
    mov di,offset P1_regs
    rep movsb   
    jmp exit_updt

    reg_BX_p1:
    mov di,offset P1_regs+5
    rep movsb   
    jmp exit_updt

    reg_CX_p1:
    mov di,offset P1_regs+10
    rep movsb   
    jmp exit_updt

    reg_DX_p1:
    mov di,offset P1_regs+15
    rep movsb   
    jmp exit_updt

    reg_SI_p1:
    mov di,offset P1_regs+20
    rep movsb   
    jmp exit_updt

    reg_DI_p1:
    mov di,offset P1_regs+25
    rep movsb   
    jmp exit_updt

    reg_SP_p1:
    mov di,offset P1_regs+30
    rep movsb   
    jmp exit_updt

    reg_BP_p1:
    mov di,offset P1_regs+35
    rep movsb   
    jmp exit_updt

    ;8-bit registers-----------------------------------------------

    Reg_byte_player1:
    add si,2

    mov cx,2
    cmp reg_num,8d
    jz reg_AH_p1

    cmp reg_num,9d
    jz reg_AL_p1

    cmp reg_num,10d
    jz reg_BH_p1

    cmp reg_num,11d
    jz reg_BL_p1

    cmp reg_num,12d
    jz reg_CH_p1

    cmp reg_num,13d
    jz reg_CL_p1

    cmp reg_num,14d
    jz reg_DH_p1

    cmp reg_num,15d
    jz reg_DL_p1

    reg_AH_p1:
    mov di,offset P1_regs
    rep movsb   
    jmp exit_updt

    reg_AL_p1:
    mov di,offset P1_regs+2
    rep movsb   
    jmp exit_updt

    reg_BH_p1:
    mov di,offset P1_regs+5
    rep movsb   
    jmp exit_updt

    reg_BL_p1:
    mov di,offset P1_regs+7
    rep movsb   
    jmp exit_updt

    reg_CH_p1:
    mov di,offset P1_regs+10
    rep movsb   
    jmp exit_updt

    reg_CL_p1:
    mov di,offset P1_regs+12
    rep movsb   
    jmp exit_updt

    reg_DH_p1:
    mov di,offset P1_regs+15
    rep movsb   
    jmp exit_updt

    reg_DL_p1:
    mov di,offset P1_regs+17
    rep movsb   
    jmp exit_updt

    ; ;PLAYER-2 -----------------------------------------------------
    PLAYER_2_REGS:

    cmp reg_num,7
    ja Reg_byte_player2

    ;16-bit registers--------------------------------------------
    mov cx,4
    cmp reg_num,0
    jz reg_AX_p2

    cmp reg_num,1
    jz reg_BX_p2

    cmp reg_num,2
    jz reg_CX_p2

    cmp reg_num,3
    jz reg_DX_p2

    cmp reg_num,4
    jz reg_SI_p2

    cmp reg_num,5
    jz reg_DI_p2

    cmp reg_num,6
    jz reg_SP_p2

    cmp reg_num,7
    jz reg_BP_p2

    reg_AX_p2:
    mov di,offset P2_regs
    rep movsb   
    jmp exit_updt

    reg_BX_p2:
    mov di,offset P2_regs+5
    rep movsb   
    jmp exit_updt

    reg_CX_p2:
    mov di,offset P2_regs+10
    rep movsb   
    jmp exit_updt

    reg_DX_p2:
    mov di,offset P2_regs+15
    rep movsb   
    jmp exit_updt

    reg_SI_p2:
    mov di,offset P2_regs+20
    rep movsb   
    jmp exit_updt

    reg_DI_p2:
    mov di,offset P2_regs+25
    rep movsb   
    jmp exit_updt

    reg_SP_p2:
    mov di,offset P2_regs+30
    rep movsb   
    jmp exit_updt

    reg_BP_p2:
    mov di,offset P2_regs+35
    rep movsb   
    jmp exit_updt

    ;8-bit registers-----------------------------------------------

    Reg_byte_player2:
    add si,2

    mov cx,2
    cmp reg_num,8d
    jz reg_AH_p2

    cmp reg_num,9d
    jz reg_AL_P2

    cmp reg_num,10d
    jz reg_BH_p2

    cmp reg_num,11d
    jz reg_BL_p2

    cmp reg_num,12d
    jz reg_CH_p2

    cmp reg_num,13d
    jz reg_CL_p2

    cmp reg_num,14d
    jz reg_DH_p2

    cmp reg_num,15d
    jz reg_DL_p2

    reg_AH_p2:
    mov di,offset P2_regs
    rep movsb   
    jmp exit_updt

    reg_AL_p2:
    mov di,offset P2_regs+2
    rep movsb   
    jmp exit_updt

    reg_BH_p2:
    mov di,offset P2_regs+5
    rep movsb   
    jmp exit_updt

    reg_BL_p2:
    mov di,offset P2_regs+7
    rep movsb   
    jmp exit_updt

    reg_CH_p2:
    mov di,offset P2_regs+10
    rep movsb   
    jmp exit_updt

    reg_CL_p2:
    mov di,offset P2_regs+12
    rep movsb   
    jmp exit_updt

    reg_DH_p2:
    mov di,offset P2_regs+15
    rep movsb   
    jmp exit_updt

    reg_DL_p2:
    mov di,offset P2_regs+17
    rep movsb   
    jmp exit_updt

    exit_updt:
    

    ResetPlaceholder
ret
UpdateRegValue endp

UpdateDataSegmentValue  proc near
    ;Player_num, Operand1_btn which represents (address 0->8), modeDS= (1->16bit, 2->update8bits)
pusha
    call Convrt_Hex_String ;takes the new value from AX and converts it to string in num_placeholder variable
    mov si,offset num_placeholder

    cmp Player_num,2
    jz player2_data


    cmp modeDS,2
    jz updt_oneSegment_p1

    mov cx,2

    cmp operand1_btn_DS,0
    jz data_0_p11
    cmp operand1_btn_DS,1
    jz data_1_p11
    cmp operand1_btn_DS,2
    jz data_2_p11
    cmp operand1_btn_DS,3
    jz data_3_p11
    cmp operand1_btn_DS,4
    jz data_4_p11
    cmp operand1_btn_DS,5
    jz data_5_p11
    cmp operand1_btn_DS,6
    jz data_6_p11
    cmp operand1_btn_DS,7
    jz data_7_p11
    cmp operand1_btn_DS,8
    jz data_8_p11

    ;------------------------------------------
    data_0_p11:
    mov di,offset P1_ds[3]
    rep movsb
    mov cx,2
    mov di,offset P1_ds
    rep movsb   
    jmp exit_updtdatasegment
    data_1_p11:
    mov di,offset P1_ds[6]
    rep movsb
    mov cx,2
    mov di,offset P1_ds[3]
    rep movsb   
    jmp exit_updtdatasegment
    data_2_p11:
    mov di,offset P1_ds[9]
    rep movsb
    mov cx,2
    mov di,offset P1_ds[6]
    rep movsb   
    jmp exit_updtdatasegment
    data_3_p11:
    mov di,offset P1_ds[12]
    rep movsb
    mov cx,2
    mov di,offset P1_ds[9]
    rep movsb   
    jmp exit_updtdatasegment
    data_4_p11:
    mov di,offset P1_ds[15]
    rep movsb
    mov cx,2
    mov di,offset P1_ds[12]
    rep movsb   
    jmp exit_updtdatasegment
    data_5_p11:
    mov di,offset P1_ds[18]
    rep movsb
    mov cx,2
    mov di,offset P1_ds[15]
    rep movsb   
    jmp exit_updtdatasegment
    data_6_p11:
    mov di,offset P1_ds[21]
    rep movsb
    mov cx,2
    mov di,offset P1_ds[18]
    rep movsb   
    jmp exit_updtdatasegment
    data_7_p11:
    mov di,offset P1_ds[24]
    rep movsb
    mov cx,2
    mov di,offset P1_ds[21]
    rep movsb   
    jmp exit_updtdatasegment
    data_8_p11:
    mov di,offset P1_ds
    rep movsb
    mov cx,2
    mov di,offset P1_ds[24]
    rep movsb   
    jmp exit_updtdatasegment



    jmp exit_updtdatasegment
    ;-----------------------------------
    ;-----------------------------------
    updt_oneSegment_p1:
    add si,2
    mov cx,2

    cmp operand1_btn_DS,0
    jz data_0_p1
    cmp operand1_btn_DS,1
    jz data_1_p1
    cmp operand1_btn_DS,2
    jz data_2_p1
    cmp operand1_btn_DS,3
    jz data_3_p1
    cmp operand1_btn_DS,4
    jz data_4_p1
    cmp operand1_btn_DS,5
    jz data_5_p1
    cmp operand1_btn_DS,6
    jz data_6_p1
    cmp operand1_btn_DS,7
    jz data_7_p1
    cmp operand1_btn_DS,8
    jz data_8_p1


    data_0_p1:
    mov di,offset P1_ds
    rep movsb   
    jmp exit_updtdatasegment
    data_1_p1:
    mov di,offset P1_ds[3]
    rep movsb   
    jmp exit_updtdatasegment
    data_2_p1:
    mov di,offset P1_ds[6]
    rep movsb   
    jmp exit_updtdatasegment
    data_3_p1:
    mov di,offset P1_ds[9]
    rep movsb   
    jmp exit_updtdatasegment
    data_4_p1:
    mov di,offset P1_ds[12]
    rep movsb   
    jmp exit_updtdatasegment
    data_5_p1:
    mov di,offset P1_ds[15]
    rep movsb   
    jmp exit_updtdatasegment
    data_6_p1:
    mov di,offset P1_ds[18]
    rep movsb   
    jmp exit_updtdatasegment
    data_7_p1:
    mov di,offset P1_ds[21]
    rep movsb   
    jmp exit_updtdatasegment
    data_8_p1:
    mov di,offset P1_ds[24]
    rep movsb   
    jmp exit_updtdatasegment
    

    ;-----------------------------------------
    player2_data:

    cmp modeDS,2
    jz updt_oneSegment_p2

    mov cx,2

    cmp operand1_btn_DS,0
    jz data_0_p22
    cmp operand1_btn_DS,1
    jz data_1_p22
    cmp operand1_btn_DS,2
    jz data_2_p22
    cmp operand1_btn_DS,3
    jz data_3_p22
    cmp operand1_btn_DS,4
    jz data_4_p22
    cmp operand1_btn_DS,5
    jz data_5_p22
    cmp operand1_btn_DS,6
    jz data_6_p22
    cmp operand1_btn_DS,7
    jz data_7_p22
    cmp operand1_btn_DS,8
    jz data_8_p22

    ;------------------------------------------
    data_0_p22:
    mov di,offset P2_ds[3]
    rep movsb
    mov cx,2
    mov di,offset P2_ds
    rep movsb   
    jmp exit_updtdatasegment
    data_1_p22:
    mov di,offset P2_ds[6]
    rep movsb
    mov cx,2
    mov di,offset P2_ds[3]
    rep movsb   
    jmp exit_updtdatasegment
    data_2_p22:
    mov di,offset P2_ds[9]
    rep movsb
    mov cx,2
    mov di,offset P2_ds[6]
    rep movsb   
    jmp exit_updtdatasegment
    data_3_p22:
    mov di,offset P2_ds[12]
    rep movsb
    mov cx,2
    mov di,offset P2_ds[9]
    rep movsb   
    jmp exit_updtdatasegment
    data_4_p22:
    mov di,offset P2_ds[15]
    rep movsb
    mov cx,2
    mov di,offset P2_ds[12]
    rep movsb   
    jmp exit_updtdatasegment
    data_5_p22:
    mov di,offset P2_ds[18]
    rep movsb
    mov cx,2
    mov di,offset P2_ds[15]
    rep movsb   
    jmp exit_updtdatasegment
    data_6_p22:
    mov di,offset P2_ds[21]
    rep movsb
    mov cx,2
    mov di,offset P2_ds[18]
    rep movsb   
    jmp exit_updtdatasegment
    data_7_p22:
    mov di,offset P2_ds[24]
    rep movsb
    mov cx,2
    mov di,offset P2_ds[21]
    rep movsb   
    jmp exit_updtdatasegment
    data_8_p22:
    mov di,offset P2_ds
    rep movsb
    mov cx,2
    mov di,offset P2_ds[24]
    rep movsb   
    jmp exit_updtdatasegment


    jmp exit_updtdatasegment
    ;------------------------------------------
    updt_oneSegment_p2:
    add si,2
    mov cx,2

    cmp operand1_btn_DS,0
    jz data_0_p2
    cmp operand1_btn_DS,1
    jz data_1_p2
    cmp operand1_btn_DS,2
    jz data_2_p2
    cmp operand1_btn_DS,3
    jz data_3_p2
    cmp operand1_btn_DS,4
    jz data_4_p2
    cmp operand1_btn_DS,5
    jz data_5_p2
    cmp operand1_btn_DS,6
    jz data_6_p2
    cmp operand1_btn_DS,7
    jz data_7_p2
    cmp operand1_btn_DS,8
    jz data_8_p2

    data_0_p2:
    add si,2
    mov di,offset P2_ds
    rep movsb   
    jmp exit_updtdatasegment
    data_1_p2:
    mov di,offset P2_ds[3]
    rep movsb   
    jmp exit_updtdatasegment
    data_2_p2:
    mov di,offset P2_ds[6]
    rep movsb   
    jmp exit_updtdatasegment
    data_3_p2:
    mov di,offset P2_ds[9]
    rep movsb   
    jmp exit_updtdatasegment
    data_4_p2:
    mov di,offset P2_ds[12]
    rep movsb   
    jmp exit_updtdatasegment
    data_5_p2:
    mov di,offset P2_ds[15]
    rep movsb   
    jmp exit_updtdatasegment
    data_6_p2:
    mov di,offset P2_ds[18]
    rep movsb   
    jmp exit_updtdatasegment
    data_7_p2:
    mov di,offset P2_ds[21]
    rep movsb   
    jmp exit_updtdatasegment
    data_8_p2:
    mov di,offset P2_ds[24]
    rep movsb   
    jmp exit_updtdatasegment

    ;ERROR_updtdatasegment:
    ;mov DataSegment_error,1

    exit_updtdatasegment:
    ResetPlaceholder
popa
ret
UpdateDataSegmentValue endp

GetbtnclickedDS proc near
    noleftclick1:
            mov ax,0003h
            int 33h ;CX(X), DX(Y)
            test bx,1
            jz noleftclick1 ;break if user clicked the left click
 
    mov bx,dx
    mov dx,0
    mov ax,cx
    mov cx,71 ;65 is the btn width
    div cx    ;integer division
 
    cmp bx,247
    ja under1
    mov ax,0ffffh
    jmp exit1
 
    under1:
        cmp bx,276
        jb row_01
        mov ax,0ffffh
        jmp exit1
        row_01:
        add ax,0
        jmp exit1
 
    exit1:
    mov btn_num,ax
    ret
GetbtnclickedDS endp

DrawDSAddress proc NEAR
;clearing buttons area
    mov ax,0600h
    mov bh,0
    mov cl,0  ;x1
    mov ch,17 ;y1
    mov dl,80 ;x2
    mov dh,20 ;y2
    int 10h

    mov xr,3d
    mov yr,247
    DrawDSbtn xr,yr

    mov xr,74d
    mov yr,247
    DrawDSbtn xr,yr

    mov xr,145d
    mov yr,247
    DrawDSbtn xr,yr

    mov xr,216d
    mov yr,247
    DrawDSbtn xr,yr

    mov xr,287d
    mov yr,247
    DrawDSbtn xr,yr

    mov xr,358d
    mov yr,247
    DrawDSbtn xr,yr

    mov xr,429d
    mov yr,247
    DrawDSbtn xr,yr

    mov xr,500d
    mov yr,247
    DrawDSbtn xr,yr

    mov xr,571d
    mov yr,247
    DrawDSbtn xr,yr

;Labels
    mov ah,2
    mov dl,4
    mov dh,18
    int 10h  
    mov ah,9
    mov dx,offset DS_labels
    int 21h

    mov ah,2
    mov dl,13
    mov dh,18
    int 10h  
    mov ah,9
    mov dx,offset DS_labels+2
    int 21h

    mov ah,2
    mov dl,22
    mov dh,18
    int 10h  
    mov ah,9
    mov dx,offset DS_labels+4
    int 21h
    
    mov ah,2
    mov dl,31
    mov dh,18
    int 10h  
    mov ah,9
    mov dx,offset DS_labels+6
    int 21h

    mov ah,2
    mov dl,40
    mov dh,18
    int 10h  
    mov ah,9
    mov dx,offset DS_labels+8
    int 21h

    mov ah,2
    mov dl,48
    mov dh,18
    int 10h  
    mov ah,9
    mov dx,offset DS_labels+10
    int 21h

    mov ah,2
    mov dl,57
    mov dh,18
    int 10h  
    mov ah,9
    mov dx,offset DS_labels+12
    int 21h

    mov ah,2
    mov dl,66
    mov dh,18
    int 10h  
    mov ah,9
    mov dx,offset DS_labels+14
    int 21h

    mov ah,2
    mov dl,75
    mov dh,18
    int 10h  
    mov ah,9
    mov dx,offset DS_labels+16
    int 21h
    ret

DrawDSAddress Endp

DrawCommandRow proc near  ;x y top left corner of the drawn rectangle

    ;clearing buttons area
    mov ax,0600h
    mov bh,0
    mov cl,0  ;x1
    mov ch,17 ;y1
    mov dl,80 ;x2
    mov dh,20 ;y2
    int 10h

    mov xr,5d
    mov yr,235
    Drawbtncommand xr,yr

    mov xr,69d
    mov yr,235
    Drawbtncommand xr,yr

    mov xr,133d
    mov yr,235
    Drawbtncommand xr,yr

    mov xr,197d
    mov yr,235
    Drawbtncommand xr,yr

    mov xr,261d
    mov yr,235
    Drawbtncommand xr,yr

    mov xr,325d
    mov yr,235
    Drawbtncommand xr,yr

    mov xr,389d
    mov yr,235
    Drawbtncommand xr,yr

    mov xr,453d
    mov yr,235
    Drawbtncommand xr,yr

    mov xr,517d
    mov yr,235
    Drawbtncommand xr,yr

    mov xr,581d
    mov yr,235
    Drawbtncommand xr,yr
;-------------------------------------------------------------

   mov xr,5d
    mov yr,265
    Drawbtncommand xr,yr

    mov xr,69d
    mov yr,265
    Drawbtncommand xr,yr

    mov xr,133d
    mov yr,265
    Drawbtncommand xr,yr

    mov xr,197d
    mov yr,265
    Drawbtncommand xr,yr

    mov xr,261d
    mov yr,265
    Drawbtncommand xr,yr

    mov xr,325d
    mov yr,265
    Drawbtncommand xr,yr

    mov xr,389d
    mov yr,265
    Drawbtncommand xr,yr

    mov xr,453d
    mov yr,265
    Drawbtncommand xr,yr

    mov xr,517d
    mov yr,265
    Drawbtncommand xr,yr

    mov xr,581d
    mov yr,265
    Drawbtncommand xr,yr
    ;--------------------------------------
    ;Labels
    mov ah,2
    mov dl,3
    mov dh,17
    int 10h  
    mov ah,9
    mov dx,offset Ladd
    int 21h

    mov ah,2
    mov dl,11
    mov dh,17
    int 10h  
    mov ah,9
    mov dx,offset Ladc
    int 21h

    mov ah,2
    mov dl,19
    mov dh,17
    int 10h  
    mov ah,9
    mov dx,offset Lsub
    int 21h
    
    mov ah,2
    mov dl,27
    mov dh,17
    int 10h  
    mov ah,9
    mov dx,offset Lsbb
    int 21h

    mov ah,2
    mov dl,35
    mov dh,17
    int 10h  
    mov ah,9
    mov dx,offset Ldiv
    int 21h

    mov ah,2
    mov dl,43
    mov dh,17
    int 10h  
    mov ah,9
    mov dx,offset Lmul
    int 21h

    mov ah,2
    mov dl,51
    mov dh,17
    int 10h  
    mov ah,9
    mov dx,offset Lxor
    int 21h

    mov ah,2
    mov dl,59
    mov dh,17
    int 10h  
    mov ah,9
    mov dx,offset Land
    int 21h

    mov ah,2
    mov dl,67
    mov dh,17
    int 10h  
    mov ah,9
    mov dx,offset Lor
    int 21h

    mov ah,2
    mov dl,75
    mov dh,17
    int 10h  
    mov ah,9
    mov dx,offset Lnop
    int 21h
    ;--------------new_row---------------
    mov ah,2
    mov dl,3
    mov dh,19
    int 10h  
    mov ah,9
    mov dx,offset Lshr
    int 21h

    mov ah,2
    mov dl,11
    mov dh,19
    int 10h  
    mov ah,9
    mov dx,offset Lshl
    int 21h

    mov ah,2
    mov dl,19
    mov dh,19
    int 10h  
    mov ah,9
    mov dx,offset Lmov
    int 21h

    mov ah,2
    mov dl,27
    mov dh,19
    int 10h  
    mov ah,9
    mov dx,offset Linc
    int 21h

    mov ah,2
    mov dl,35
    mov dh,19
    int 10h  
    mov ah,9
    mov dx,offset Ldec
    int 21h

    mov ah,2
    mov dl,43
    mov dh,19
    int 10h  
    mov ah,9
    mov dx,offset Lclc
    int 21h

    mov ah,2
    mov dl,51
    mov dh,19
    int 10h  
    mov ah,9
    mov dx,offset Lidiv
    int 21h

    mov ah,2
    mov dl,59
    mov dh,19
    int 10h  
    mov ah,9
    mov dx,offset Limul
    int 21h

    mov ah,2
    mov dl,67
    mov dh,19
    int 10h  
    mov ah,9
    mov dx,offset Lror
    int 21h

    mov ah,2
    mov dl,75
    mov dh,19
    int 10h  
    mov ah,9
    mov dx,offset Lrol
    int 21h
    ret
DrawCommandRow Endp

DrawAddressingRow proc near
    ;clearing buttons area
    mov ax,0600h
    mov bh,0
    mov cl,0  ;x1
    mov ch,17 ;y1
    mov dl,80 ;x2
    mov dh,20 ;y2
    int 10h

    mov xr,5d
    mov yr,235
    Drawbtncommand xr,yr

    mov xr,69d
    mov yr,235
    Drawbtncommand xr,yr

    mov xr,133d
    mov yr,235
    Drawbtncommand xr,yr

    mov xr,197d
    mov yr,235
    Drawbtncommand xr,yr

    mov xr,261d
    mov yr,235
    Drawbtncommand xr,yr

    mov xr,325d
    mov yr,235
    Drawbtncommand xr,yr

    mov xr,389d
    mov yr,235
    Drawbtncommand xr,yr

    mov xr,453d
    mov yr,235
    Drawbtncommand xr,yr

    mov xr,517d
    mov yr,235
    Drawbtncommand xr,yr

    mov xr,581d
    mov yr,235
    Drawbtncommand xr,yr
;-------------------------------------------------------------

   mov xr,5d
    mov yr,265
    Drawbtncommand xr,yr

    mov xr,69d
    mov yr,265
    Drawbtncommand xr,yr

    mov xr,133d
    mov yr,265
    Drawbtncommand xr,yr

    mov xr,197d
    mov yr,265
    Drawbtncommand xr,yr

    mov xr,261d
    mov yr,265
    Drawbtncommand xr,yr

    mov xr,325d
    mov yr,265
    Drawbtncommand xr,yr

    mov xr,389d
    mov yr,265
    Drawbtncommand xr,yr

    mov xr,453d
    mov yr,265
    Drawbtncommand xr,yr

    mov xr,517d
    mov yr,265
    Drawbtncommand xr,yr

    mov xr,581d
    mov yr,265
    Drawbtncommand xr,yr



  ;Labels
    mov ah,2
    mov dl,3
    mov dh,17
    int 10h  
    mov ah,9
    mov dx,offset Lax
    int 21h

    mov ah,2
    mov dl,11
    mov dh,17
    int 10h  
    mov ah,9
    mov dx,offset Lbx
    int 21h

    mov ah,2
    mov dl,19
    mov dh,17
    int 10h  
    mov ah,9
    mov dx,offset Lcx
    int 21h
    
    mov ah,2
    mov dl,27
    mov dh,17
    int 10h  
    mov ah,9
    mov dx,offset Ldx
    int 21h

    mov ah,2
    mov dl,35
    mov dh,17
    int 10h  
    mov ah,9
    mov dx,offset Lsi
    int 21h

    mov ah,2
    mov dl,43
    mov dh,17
    int 10h  
    mov ah,9
    mov dx,offset Ldi
    int 21h

    mov ah,2
    mov dl,51
    mov dh,17
    int 10h  
    mov ah,9
    mov dx,offset Lsp
    int 21h

    mov ah,2
    mov dl,59
    mov dh,17
    int 10h  
    mov ah,9
    mov dx,offset Lbp
    int 21h

    mov ah,2
    mov dl,67
    mov dh,17
    int 10h  
    mov ah,9
    mov dx,offset Lah
    int 21h

    mov ah,2
    mov dl,75
    mov dh,17
    int 10h  
    mov ah,9
    mov dx,offset Lal
    int 21h

    ;--------------new_row---------------

    mov ah,2
    mov dl,3
    mov dh,19
    int 10h  
    mov ah,9
    mov dx,offset Lbh
    int 21h

    mov ah,2
    mov dl,11
    mov dh,19
    int 10h  
    mov ah,9
    mov dx,offset Lbl
    int 21h

    mov ah,2
    mov dl,19
    mov dh,19
    int 10h  
    mov ah,9
    mov dx,offset Lch
    int 21h

    mov ah,2
    mov dl,27
    mov dh,19
    int 10h  
    mov ah,9
    mov dx,offset Lcl
    int 21h

    mov ah,2
    mov dl,35
    mov dh,19
    int 10h  
    mov ah,9
    mov dx,offset Ldh
    int 21h

    mov ah,2
    mov dl,43
    mov dh,19
    int 10h  
    mov ah,9
    mov dx,offset Ldl
    int 21h

    mov ah,2
    mov dl,50
    mov dh,19
    int 10h  
    mov ah,9
    mov dx,offset Limd_adr
    int 21h

    mov ah,2
    mov dl,59
    mov dh,19
    int 10h  
    mov ah,9
    mov dx,offset Ldir_adr
    int 21h

    mov ah,2
    mov dl,66
    mov dh,19
    int 10h  
    mov ah,9
    mov dx,offset Lind_adr
    int 21h

    mov ah,2
    mov dl,73
    mov dh,19
    int 10h  
    mov ah,9
    mov dx,offset Lbas_adr
    int 21h
    ret
DrawAddressingRow Endp
GetDataSegmentValue proc near
    ;little indian lw 3ayez 1 dakhalo 0 w khod ch
    ;local exit_getdatasegmentvalue,player2,data_01_p1,data_23_p1,data_45_p1,data_67_p1,data_80_p1,data_01_p2,data_23_p2,data_45_p2,data_67_p2,data_80_p2
    ;convrt_string_hex MACRO STR,mode 
    ;This macro always returns 2 data slots in CH:CL respectively
    ;e.g: address =1 , therefore CX= addr[2]:addr[1] both of them, if u need the exact address u sent (8bits slot) use CH
    ;NOTE: address values: 0, 2, 4, 6, 8
    cmp Player_num,2
    jz player2

    mov get_datasegment_mode,2

    cmp DSAdd,0
    jz data_01_p1
    cmp DSAdd,2
    jz data_23_p1
    cmp DSAdd,4
    jz data_45_p1
    cmp DSAdd,6
    jz data_67_p1
    cmp DSAdd,8
    jz data_80_p1
    
    data_01_p1:
    convrt_string_hex P1_ds-2,get_datasegment_mode
    mov temp1,cl
    convrt_string_hex P1_ds+1,get_datasegment_mode
    mov ch,temp1
    xchg ch,cl
    jmp exit_getdatasegmentvalue
    data_23_p1:
    convrt_string_hex P1_ds+4,get_datasegment_mode
    xchg ch,cl
    convrt_string_hex P1_ds+7,get_datasegment_mode
    jmp exit_getdatasegmentvalue
    data_45_p1:
    convrt_string_hex P1_ds+10,get_datasegment_mode
    xchg ch,cl
    convrt_string_hex P1_ds+13,get_datasegment_mode
    jmp exit_getdatasegmentvalue
    data_67_p1:
    convrt_string_hex P1_ds+16,get_datasegment_mode
    xchg ch,cl
    convrt_string_hex P1_ds+19,get_datasegment_mode
    jmp exit_getdatasegmentvalue
    data_80_p1:
    convrt_string_hex P1_ds+22,get_datasegment_mode
    xchg ch,cl
    convrt_string_hex P1_ds-2,get_datasegment_mode
    jmp exit_getdatasegmentvalue
    ;-----------------------------------
    player2:
    cmp DSAdd,0
    jz data_01_p2
    cmp DSAdd,2
    jz data_23_p2
    cmp DSAdd,4
    jz data_45_p2
    cmp DSAdd,6
    jz data_67_p2
    cmp DSAdd,8
    jz data_80_p2
    
    data_01_p2:
    convrt_string_hex P2_ds-2,get_datasegment_mode
    mov temp1,cl
    convrt_string_hex P2_ds+1,get_datasegment_mode
    mov ch,temp1
    xchg ch,cl
    jmp exit_getdatasegmentvalue
    data_23_p2:
    convrt_string_hex P2_ds+4,get_datasegment_mode
    xchg ch,cl
    convrt_string_hex P2_ds+7,get_datasegment_mode
    jmp exit_getdatasegmentvalue
    data_45_p2:
    convrt_string_hex P2_ds+10,get_datasegment_mode
    xchg ch,cl
    convrt_string_hex P2_ds+13,get_datasegment_mode
    jmp exit_getdatasegmentvalue
    data_67_p2:
    convrt_string_hex P2_ds+16,get_datasegment_mode
    xchg ch,cl
    convrt_string_hex P2_ds+19,get_datasegment_mode
    jmp exit_getdatasegmentvalue
    data_80_p2:
    convrt_string_hex P2_ds+22,get_datasegment_mode
    xchg ch,cl
    convrt_string_hex P2_ds-2,get_datasegment_mode
    jmp exit_getdatasegmentvalue

    exit_getdatasegmentvalue:
    ret
GetDataSegmentValue Endp

; BtnAct proc near 
;    ; local exit
; ; mov OpBtn,ax
; cmp OpBtn,9
; je exit007
; cmp OpBtn,15
; je ClearCarry

; Call DrawAddressingRow
; Ops btn_num
; jmp exit007
; ClearCarry:
; CLC

;    exit007: 
;    ret
; BtnAct Endp

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
		
        mov dx,3FDH		; Line Status Register
	    in al,dx 
  		test al,1
  		JZ CHK                                  ;Not Ready
 ;If Ready read the VALUE in Receive data register
  		mov dx , 03F8H
  		in al , dx
  		mov RecMess,al
     CHK:
        
        pushf
ret
receive endp



sendReg proc near
pusha
;Check that Transmitter Holding Register is Empty
        mov cl,80
        mov si,0
    DOIT1:
    AGAIN1:
        mov dx , 3FDH		; Line Status Register
        In al , dx 			;Read Line Status
  		test al , 00100000b
  		JZ AGAIN1                              ;Not empty

;If empty put the VALUE in Transmit data register
  	 mov dx , 3F8H ; Transmit data register
  		mov al,P1_regs[si]
        out dx , al
        inc si
        dec cl
        jnz DOIT1
popa
ret
sendReg endp

receiveReg proc near
pusha
;Check that Data is Ready
        mov cx,80
        mov si,0
	DOIT11:
    CHK1:	
        mov dx,3FDH		; Line Status Register
	    in al,dx 
  		test al,1
  		JZ CHK1                                  ;Not Ready
 ;If Ready read the VALUE in Receive data register
  	    mov dx , 03F8H
  		 in al , dx
  	 	 mov P1_regs[si],al
         inc si
         dec cx
         jnz DOIT11  
popa
ret
receiveReg endp

receiveTurn proc near
pusha
;Check that Data is Ready
	CHK2:	
        mov dx,3FDH		; Line Status Register
	    in al,dx 
  		test al,1
  		JZ CHK2                                  ;Not Ready
 ;If Ready read the VALUE in Receive data register
  	    mov dx , 03F8H
  		 in al , dx
        mov ah,0
  	 	mov Player_turn,ax
popa          
ret
receiveTurn endp

sendTurn proc near
pusha
;Check that Transmitter Holding Register is Empty
    AGAIN22:
        mov dx , 3FDH		; Line Status Register
        In al , dx 			;Read Line Status
  		test al , 00100000b
  		JZ AGAIN22                               ;Not empty

;If empty put the VALUE in Transmit data register
  	    mov dx , 3F8H ; Transmit data register
  		mov ax,Player_turn
        out dx , ax
popa
ret
sendTurn endp

receivePTS proc near
pusha
;Check that Data is Ready
	mov cx,4
    mov si,0
    keeprec:
    CHK22:	
        mov dx,3FDH		; Line Status Register
	    in al,dx 
  		test al,1
  		JZ CHK22                                  ;Not Ready
 ;If Ready read the VALUE in Receive data register
  	    mov dx , 03F8H
  		 in al , dx
        mov ah,0
  	 	mov P1_init_points[si],al
        inc si
        dec cx
        jnz keeprec
popa          
ret
receivePTS endp

sendPTS proc near
pusha
;Check that Transmitter Holding Register is Empty
    mov cx,4
    mov si,0
    keepsending:
    AGAIN222:
        mov dx , 3FDH		; Line Status Register
        In al , dx 			;Read Line Status
  		test al , 00100000b
  		JZ AGAIN222                               ;Not empty

;If empty put the VALUE in Transmit data register
  	    mov dx , 3F8H ; Transmit data register
  		mov al,P2_init_points[si]
        out dx , al
        inc si
        dec cx
        jnz keepsending
popa
ret
sendPTS endp


receiveName proc near
pusha
;Check that Data is Ready
	mov cx,10
    mov si,2
    keeprec1:
    CHK222: 	
        mov dx,3FDH		; Line Status Register
	    in al,dx 
  		test al,1
  		JZ CHK222                                  ;Not Ready
 ;If Ready read the VALUE in Receive data register
  	   mov dx , 03F8H
  		 in al , dx
        mov ah,0
  	 	mov user_name[si],al
        inc si
        dec cx
        jnz keeprec1
        
popa          
ret
receiveName endp

sendName proc near
pusha
;Check that Transmitter Holding Register is Empty
    mov cl,10
    mov si,2
    keepsending1:
    AGAIN2222:
        mov dx , 3FDH		; Line Status Register
        In al , dx 			;Read Line Status
  		test al , 00100000b
  		JZ AGAIN2222                       ;Not empty

;If empty put the VALUE in Transmit data register
  	    mov dx , 3F8H ; Transmit data register
  		mov al,user2_name[si]
        out dx , al
        inc si
        dec cl
        jnz keepsending1
popa
ret
sendName endp

sendP2info proc NEAR
pusha
;Check that Transmitter Holding Register is Empty
    AGAIN333:
        mov dx , 3FDH		; Line Status Register
        In al , dx 			;Read Line Status
  		test al , 00100000b
  		JZ AGAIN333                               ;Not empty

;If empty put the VALUE in Transmit data register
  	    mov dx , 3F8H ; Transmit data register
  		mov al,getp2info
        out dx , al
popa
ret
sendP2info endp

receivep1info proc near
pusha
;Check that Data is Ready
	CHK3:	
        mov dx,3FDH		; Line Status Register
	    in al,dx 
  		test al,1
  		JZ CHK3                                  ;Not Ready
 ;If Ready read the VALUE in Receive data register
  	    mov dx , 03F8H
  		 in al , dx
        ;mov ah,0
  	 	mov getP1info,al
popa          
ret
receivep1info endp

receiveLvl proc near
pusha
;Check that Data is Ready
	CHK34:	
        mov dx,3FDH		; Line Status Register
	    in al,dx 
  		test al,1
  		JZ CHK34                                  ;Not Ready
 ;If Ready read the VALUE in Receive data register
  	    mov dx , 03F8H
  		 in al , dx
        ;mov ah,0
  	 	mov Level,al
popa          
ret
receiveLvl endp


sendP2frbdn proc NEAR
pusha
mov cx,4
mov si,0

;Check that Transmitter Holding Register is Empty
    AGAIN4:
        mov dx , 3FDH		; Line Status Register
        In al , dx 			;Read Line Status
  		test al , 00100000b
  		JZ AGAIN4                               ;Not empty

;If empty put the VALUE in Transmit data register
  	    mov dx , 3F8H ; Transmit data register
  		mov al,P2_FrbdnChar[si]
        out dx , al
        inc si
        dec cx
        jnz AGAIN4
popa
ret
sendP2frbdn endp

receivep1frbdn proc near
pusha
mov cx,4
mov si,0
;Check that Data is Ready
	CHK4:	
        mov dx,3FDH		; Line Status Register
	    in al,dx 
  		test al,1
  		JZ CHK4                                  ;Not Ready
 ;If Ready read the VALUE in Receive data register
  	    mov dx , 03F8H
  		 in al , dx
        ;mov ah,0
  	 	mov P1_FrbdnChar[si],al
        inc si
        dec cx
        jnz CHK4
popa          
ret
receivep1frbdn endp

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

CreateLevelChoiceMenu proc near
mov point_x,25d
mov point_y,10d
SetCursor point_x,point_y
ShowMessage choose_Level1_message
;----------------------------------------
mov point_x,25d
mov point_y,12d
SetCursor point_x,point_y
ShowMessage choose_Level2_message
;----------------------------------------
mov point_x,25d
mov point_y,14d
SetCursor point_x,point_y
ShowMessage press_level_choice

ret
CreateLevelChoiceMenu Endp

end Main