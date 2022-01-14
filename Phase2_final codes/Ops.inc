Ops MACRO btn_num
local EXIT1
cmp flagpower1_own,1
jz activate_pw1
jmp skippw
activate_pw1:
    cmp Player_turn,2
    je chng_turn1
    jmp chng_turn22
    chng_turn1:
    mov Player_turn,1
    jmp Skippw
    chng_turn22:
    mov Player_turn,2
Skippw:

mov cmndStringLength,0   
firstReg:
mov ah,0ch
mov al,0
int 21h
mov ah,0
int 16h
Call Getbtnclicked 
mov operand1_btn,al
cmp ax,0ffffh
jz firstReg 
cmp ax, 0 
jz axb1
cmp ax, 1 
jz bxb1   
cmp ax, 2 
jz cxb1
cmp ax, 3 
jz dxb1
cmp ax, 4 
jz sib1
cmp ax, 5 
jz dib1
cmp ax, 6 
jz spb1
cmp ax, 7 
jz bpb1
cmp ax, 8 
jz ahb1
cmp ax, 9 
jz alb1
cmp ax, 10
jz bhb1
cmp ax, 11
jz blb1
cmp ax, 12 
jz chb1
cmp ax, 13
jz clb1
cmp ax, 14
jz dhb1
cmp ax, 15
jz dlb1
cmp ax, 16
jz Errors

cmp ax, 17    ;; take 1st operand again from the buttons
jz directaddb

; cmp ax, 18
; jz indirectregb

; cmp ax, 19
; jz basedaddb
axb1:
;Creating Command String
mov SI,offset Lax
mov DI,offset commandString
mov cx,2
rep MOVSB
add cmndStringLength,2

cmp Player_turn,1   ;Player_turn = 0 if it's P1's Player_turn , Player_turn =1 if it's P2's Player_turn
jz p2_AX
convrt_string_hex P1_regs,mode ;; me7tageen ne8ayar P1_regs 3ala 7asab meen first operand P1_regs+5,10,15
mov operand1,CX
jmp getop2
p2_AX:
convrt_string_hex P2_regs,mode
mov operand1,CX
jmp getop2

bxb1:
;Creating Command String
mov SI,offset Lbx
mov DI,offset commandString
mov cx,2
rep MOVSB
add cmndStringLength,2

cmp Player_turn,1   ;Player_turn = 0 if it's P1's Player_turn , Player_turn =1 if it's P2's Player_turn
jz p2_BX
convrt_string_hex P1_regs+5,mode ;; me7tageen ne8ayar P1_regs 3ala 7asab meen first operand P1_regs+5,10,15
mov operand1,CX
jmp getop2
p2_BX:
convrt_string_hex P2_regs+5,mode
mov operand1,CX
jmp getop2

cxb1:
;Creating Command String
mov SI,offset Lcx
mov DI,offset commandString
mov cx,2
rep MOVSB
add cmndStringLength,2

cmp Player_turn,1   ;Player_turn = 0 if it's P1's Player_turn , Player_turn =1 if it's P2's Player_turn
jz p2_CX
convrt_string_hex P1_regs+10,mode ;; me7tageen ne8ayar P1_regs 3ala 7asab meen first operand P1_regs+5,10,15
mov operand1,CX
jmp getop2
p2_CX:
convrt_string_hex P2_regs+10,mode
mov operand1,CX
jmp getop2

dxb1:
;Creating Command String
mov SI,offset Ldx
mov DI,offset commandString
mov cx,2
rep MOVSB
add cmndStringLength,2

cmp Player_turn,1   ;Player_turn = 0 if it's P1's Player_turn , Player_turn =1 if it's P2's Player_turn
jz p2_DX
convrt_string_hex P1_regs+15,mode ;; me7tageen ne8ayar P1_regs 3ala 7asab meen first operand P1_regs+5,10,15
mov operand1,CX
jmp getop2
p2_DX:
convrt_string_hex P2_regs+15,mode
mov operand1,CX
jmp getop2

sib1:
;Creating Command String
mov SI,offset Lsi
mov DI,offset commandString
mov cx,2
rep MOVSB
add cmndStringLength,2

cmp Player_turn,1   ;Player_turn = 0 if it's P1's Player_turn , Player_turn =1 if it's P2's Player_turn
jz p2_SI
convrt_string_hex P1_regs+20,mode ;; me7tageen ne8ayar P1_regs 3ala 7asab meen first operand P1_regs+5,10,15
mov operand1,CX
jmp getop2
p2_SI:
convrt_string_hex P2_regs+20,mode
mov operand1,CX
jmp getop2

dib1:
;Creating Command String
mov SI,offset Ldi
mov DI,offset commandString
mov cx,2
rep MOVSB
add cmndStringLength,2

cmp Player_turn,1   ;Player_turn = 0 if it's P1's Player_turn , Player_turn =1 if it's P2's Player_turn
jz p2_DI
convrt_string_hex P1_regs+25,mode ;; me7tageen ne8ayar P1_regs 3ala 7asab meen first operand P1_regs+5,10,15
mov operand1,CX
jmp getop2
p2_DI:
convrt_string_hex P2_regs+25,mode
mov operand1,CX
jmp getop2

spb1:
;Creating Command String
mov SI,offset Lsp
mov DI,offset commandString
mov cx,2
rep MOVSB
add cmndStringLength,2

cmp Player_turn,1   ;Player_turn = 0 if it's P1's Player_turn , Player_turn =1 if it's P2's Player_turn
jz p2_SP
convrt_string_hex P1_regs+30,mode ;; me7tageen ne8ayar P1_regs 3ala 7asab meen first operand P1_regs+5,10,15
mov operand1,CX
jmp getop2
p2_SP:
convrt_string_hex P2_regs+30,mode
mov operand1,CX
jmp getop2

bpb1:
;Creating Command String
mov SI,offset Lbp
mov DI,offset commandString
mov cx,2
rep MOVSB
add cmndStringLength,2

cmp Player_turn,1   ;Player_turn = 0 if it's P1's Player_turn , Player_turn =1 if it's P2's Player_turn
jz p2_BP
convrt_string_hex P1_regs+35,mode ;; me7tageen ne8ayar P1_regs 3ala 7asab meen first operand P1_regs+5,10,15
mov operand1,CX
jmp getop2
p2_BP:
convrt_string_hex P2_regs+35,mode
mov operand1,CX
jmp getop2

ahb1:
;Creating Command String
mov SI,offset Lah
mov DI,offset commandString
mov cx,2
rep MOVSB
add cmndStringLength,2

cmp Player_turn,1   ;Player_turn = 0 if it's P1's Player_turn , Player_turn =1 if it's P2's Player_turn
jz p2_AH
mov mode,2
convrt_string_hex P1_regs-2,mode ;; me7tageen ne8ayar P1_regs 3ala 7asab meen first operand P1_regs+5,10,15
mov operand1,CX
jmp getop2
p2_AH:
mov mode,2
convrt_string_hex P2_regs-2,mode
mov operand1,CX
jmp getop2

alb1:
;Creating Command String
mov SI,offset Lal
mov DI,offset commandString
mov cx,2
rep MOVSB
add cmndStringLength,2

cmp Player_turn,1   ;Player_turn = 0 if it's P1's Player_turn , Player_turn =1 if it's P2's Player_turn
jz p2_AL
mov mode,2
convrt_string_hex P1_regs,mode ;; me7tageen ne8ayar P1_regs 3ala 7asab meen first operand P1_regs+5,10,15
mov operand1,CX
jmp getop2
p2_AL:
mov mode,2
convrt_string_hex P2_regs,mode
mov operand1,CX
jmp getop2

bhb1:
;Creating Command String
mov SI,offset Lbh
mov DI,offset commandString
mov cx,2
rep MOVSB
add cmndStringLength,2

cmp Player_turn,1   ;Player_turn = 0 if it's P1's Player_turn , Player_turn =1 if it's P2's Player_turn
jz p2_BH
mov mode,2
convrt_string_hex P1_regs+3,mode ;; me7tageen ne8ayar P1_regs 3ala 7asab meen first operand P1_regs+5,10,15
mov operand1,CX
jmp getop2
p2_BH:
mov mode,2
convrt_string_hex P2_regs+3,mode
mov operand1,CX
jmp getop2

blb1:
;Creating Command String
mov SI,offset Lbl
mov DI,offset commandString
mov cx,2
rep MOVSB
add cmndStringLength,2

cmp Player_turn,1   ;Player_turn = 0 if it's P1's Player_turn , Player_turn =1 if it's P2's Player_turn
jz p2_BL
mov mode,2
convrt_string_hex P1_regs+5,mode ;; me7tageen ne8ayar P1_regs 3ala 7asab meen first operand P1_regs+5,10,15
mov operand1,CX
jmp getop2
p2_BL:
mov mode,2
convrt_string_hex P2_regs+5,mode
mov operand1,CX
jmp getop2

chb1:
;Creating Command String
mov SI,offset Lch
mov DI,offset commandString
mov cx,2
rep MOVSB
add cmndStringLength,2

cmp Player_turn,1   ;Player_turn = 0 if it's P1's Player_turn , Player_turn =1 if it's P2's Player_turn
jz p2_CH
mov mode,2
convrt_string_hex P1_regs+8,mode ;; me7tageen ne8ayar P1_regs 3ala 7asab meen first operand P1_regs+5,10,15
mov operand1,CX
jmp getop2
p2_CH:
mov mode,2
convrt_string_hex P2_regs+8,mode
mov operand1,CX
jmp getop2

clb1:
mov SI,offset Lcl
mov DI,offset commandString
mov cx,2
rep MOVSB
add cmndStringLength,2

cmp Player_turn,1   ;Player_turn = 0 if it's P1's Player_turn , Player_turn =1 if it's P2's Player_turn
jz p2_CL
mov mode,2
convrt_string_hex P1_regs+10,mode ;; me7tageen ne8ayar P1_regs 3ala 7asab meen first operand P1_regs+5,10,15
mov operand1,CX
jmp getop2
p2_CL:
mov mode,2
convrt_string_hex P2_regs+10,mode
mov operand1,CX
jmp getop2

dhb1:
mov SI,offset Ldh
mov DI,offset commandString
mov cx,2
rep MOVSB
add cmndStringLength,2

cmp Player_turn,1   ;Player_turn = 0 if it's P1's Player_turn , Player_turn =1 if it's P2's Player_turn
jz p2_DH
mov mode,2
convrt_string_hex P1_regs+13,mode ;; me7tageen ne8ayar P1_regs 3ala 7asab meen first operand P1_regs+5,10,15
mov operand1,CX
jmp getop2
p2_DH:
mov mode,2
convrt_string_hex P2_regs+13,mode
mov operand1,CX
jmp getop2

dlb1:
mov SI,offset Ldl
mov DI,offset commandString
mov cx,2
rep MOVSB
add cmndStringLength,2

cmp Player_turn,1   ;Player_turn = 0 if it's P1's Player_turn , Player_turn =1 if it's P2's Player_turn
jz p2_DL
mov mode,2
convrt_string_hex P1_regs+15,mode ;; me7tageen ne8ayar P1_regs 3ala 7asab meen first operand P1_regs+5,10,15
mov operand1,CX
jmp getop2
p2_DL:
mov mode,2
convrt_string_hex P2_regs+15,mode
mov operand1,CX
jmp getop2

directaddb:
Call DrawDSAddress
mov ah,0ch
mov al,0
int 21h
mov ah,0
int 16h
call GetbtnclickedDS
mov operand1_btn_DS,al
cmp ax,0ffffh
jz directaddb 
cmp ax, 0 
jz add0_op1  
cmp ax, 1 
jz add1_op1 
cmp ax, 2 
jz add2_op1
cmp ax, 3 
jz add3_op1 
cmp ax, 4 
jz add4_op1
cmp ax, 5 
jz add5_op1 
cmp ax, 6 
jz add6_op1
cmp ax, 7 
jz add7_op1 
cmp ax, 8 
jz add8_op1

add0_op1: 
cmp Player_turn,1   ;Player_turn = 1 if it's P1's Player_turn , Player_turn =2 if it's P2's Player_turn
jz P2_add0_1
mov Player_num,1
mov DSAdd,0
Call GetDataSegmentValue  ;Now we got address 0 in cl and address 1 in ch
mov operand1,CX
jmp getop2
P2_add0_1:
mov Player_num,2
mov DSAdd,0
Call GetDataSegmentValue   ;Now we got address 0 in cl and address 1 in ch
mov operand1,CX
jmp getop2

add1_op1:
jmp add0_op1

add2_op1: 
cmp Player_turn,1   ;Player_turn = 1 if it's P1's Player_turn , Player_turn =2 if it's P2's Player_turn
jz P2_add2_1
mov Player_num,1
mov DSAdd,2
Call GetDataSegmentValue   ;Now we got address 2 in cl and address 3 in ch
mov operand1,CX
jmp getop2
P2_add2_1:
mov Player_num,2
mov DSAdd,2
Call GetDataSegmentValue   ;Now we got address 2 in cl and address 3 in ch
mov operand1,CX
jmp getop2

add3_op1:
jmp add2_op1

add4_op1: 
cmp Player_turn,1   ;Player_turn = 1 if it's P1's Player_turn , Player_turn =2 if it's P2's Player_turn
jz P2_add4_1
mov Player_num,1
mov DSAdd,4
Call GetDataSegmentValue   ;Now we got address 4 in cl and address 5 in ch
mov operand1,CX
jmp getop2
P2_add4_1:
mov Player_num,2
mov DSAdd,4
Call GetDataSegmentValue   ;Now we got address 4 in cl and address 5 in ch
mov operand1,CX
jmp getop2

add5_op1:
jmp add4_op1

add6_op1: 
cmp Player_turn,1   ;Player_turn = 1 if it's P1's Player_turn , Player_turn =2 if it's P2's Player_turn
jz P2_add6_1
mov Player_num,1
mov DSAdd,6
Call GetDataSegmentValue   ;Now we got address 6 in cl and address 7 in ch
mov operand1,CX
jmp getop2
P2_add6_1:
mov Player_num,2
mov DSAdd,6
Call GetDataSegmentValue   ;Now we got address 6 in cl and address 7 in ch
mov operand1,CX
jmp getop2

add7_op1:
jmp add6_op1

add8_op1: 
cmp Player_turn,1   ;Player_turn = 1 if it's P1's Player_turn , Player_turn =2 if it's P2's Player_turn
jz P2_add8_1
mov Player_num,1
mov DSAdd,8
Call GetDataSegmentValue   ;Now we got address 8 in cl and address 0 in ch (wrap around)
mov operand1,CX
jmp getop2
P2_add8_1:
mov Player_num,2
mov DSAdd,8
Call GetDataSegmentValue   ;Now we got address 8 in cl and address 0 in ch (wrap around)
mov operand1,CX
jmp getop2


getop2:
        cmp OpBtn,4    ;No operand2 for DIV
        jz skipp
        cmp OpBtn,5    ;No operand2 for MUL
        jz skipp 
        cmp OpBtn,13   ;No operand2 for INC
        jz skipp
        cmp OpBtn,14   ;No operand2 for DEC
        jz skipp
        cmp OpBtn,16   ;;No operand2 for IDIV
        jz skipp
        cmp OpBtn,17   ;;No operand2 for IMUL
        jz skipp
        Call DrawAddressingRow
        mov ah,0ch
        mov al,0
        int 21h
        mov ah,0
        int 16h
        Call Getbtnclicked
        mov operand2_btn,al
        cmp ax,0ffffh
        jz getop2
        cmp ax, 0 
        jz axb2
        cmp ax, 1 
        jz bxb2
        cmp ax, 2 
        jz cxb2
        cmp ax, 3 
        jz dxb2
        cmp ax, 4 
        jz sib2
        cmp ax, 5 
        jz dib2
        cmp ax, 6 
        jz spb2
        cmp ax, 7 
        jz bpb2
        cmp ax, 8 
        jz ahb2
        cmp ax, 9 
        jz alb2
        cmp ax, 10
        jz bhb2
        cmp ax, 11
        jz blb2
        cmp ax, 12 
        jz chb2
        cmp ax, 13
        jz clb2
        cmp ax, 14
        jz dhb2
        cmp ax, 15
        jz dlb2
        cmp ax, 16
        jz immediateaddb2
        cmp ax, 17  
        jz directaddb2
        ; cmp ax, 18
        ; jz indirectregb2
        ; cmp ax, 19
        ; jz basedaddb2
axb2:
;Creating Command String
;mov bx,cmndStringLength
mov SI,offset Lax
mov DI,offset commandString
add DI,cmndStringLength
mov cx,2
rep MOVSB
add cmndStringLength,2

cmp Player_turn,1   ;Player_turn = 0 if it's P1's Player_turn , Player_turn =1 if it's P2's Player_turn
jz p2_AX2
convrt_string_hex P1_regs,mode
mov operand2,CX
jmp skipp
p2_AX2:
convrt_string_hex P2_regs,mode
mov operand2,CX
jmp skipp

bxb2:
;Creating Command String
mov SI,offset Lbx
mov DI,offset commandString
add DI,cmndStringLength
mov cx,2
rep MOVSB
add cmndStringLength,2

cmp Player_turn,1   ;Player_turn = 0 if it's P1's Player_turn , Player_turn =1 if it's P2's Player_turn
jz p2_BX2
convrt_string_hex P1_regs+5,mode
mov operand2,CX
jmp skipp
p2_BX2:
convrt_string_hex P2_regs+5,mode
mov operand2,CX
jmp skipp

cxb2:
;Creating Command String
mov SI,offset Lcx
mov DI,offset commandString
add DI,cmndStringLength
mov cx,2
rep MOVSB
add cmndStringLength,2

cmp Player_turn,1   ;Player_turn = 0 if it's P1's Player_turn , Player_turn =1 if it's P2's Player_turn
jz p2_CX2
convrt_string_hex P1_regs+10,mode
mov operand2,CX
jmp skipp
p2_CX2:
convrt_string_hex P2_regs+10,mode
mov operand2,CX
jmp skipp

dxb2:
;Creating Command String
mov SI,offset Ldx
mov DI,offset commandString
add DI,cmndStringLength
mov cx,2
rep MOVSB
add cmndStringLength,2

cmp Player_turn,1   ;Player_turn = 0 if it's P1's Player_turn , Player_turn =1 if it's P2's Player_turn
jz p2_DX2
convrt_string_hex P1_regs+15,mode
mov operand2,CX
jmp skipp
p2_DX2:
convrt_string_hex P2_regs+15,mode
mov operand2,CX
jmp skipp

sib2:
;Creating Command String
mov SI,offset Lsi
mov DI,offset commandString
add DI,cmndStringLength
mov cx,2
rep MOVSB
add cmndStringLength,2

cmp Player_turn,1   ;Player_turn = 0 if it's P1's Player_turn , Player_turn =1 if it's P2's Player_turn
jz p2_SI2
convrt_string_hex P1_regs+20,mode
mov operand2,CX
jmp skipp
p2_SI2:
convrt_string_hex P2_regs+20,mode
mov operand2,CX
jmp skipp

dib2:
;Creating Command String
mov SI,offset Ldi
mov DI,offset commandString
add DI,cmndStringLength
mov cx,2
rep MOVSB
add cmndStringLength,2

cmp Player_turn,1   ;Player_turn = 0 if it's P1's Player_turn , Player_turn =1 if it's P2's Player_turn
jz p2_DI2
convrt_string_hex P1_regs+25,mode
mov operand2,CX
jmp skipp
p2_DI2:
convrt_string_hex P2_regs+25,mode
mov operand2,CX
jmp skipp

spb2:
;Creating Command String
mov SI,offset Lsp
mov DI,offset commandString
add DI,cmndStringLength
mov cx,2
rep MOVSB
add cmndStringLength,2

cmp Player_turn,1   ;Player_turn = 0 if it's P1's Player_turn , Player_turn =1 if it's P2's Player_turn
jz p2_SP2
convrt_string_hex P1_regs+30,mode
mov operand2,CX
jmp skipp
p2_SP2:
convrt_string_hex P2_regs+30,mode
mov operand2,CX
jmp skipp

bpb2:
;Creating Command String
mov SI,offset Lbp
mov DI,offset commandString
add DI,cmndStringLength
mov cx,2
rep MOVSB
add cmndStringLength,2

cmp Player_turn,1   ;Player_turn = 0 if it's P1's Player_turn , Player_turn =1 if it's P2's Player_turn
jz p2_BP2
convrt_string_hex P1_regs+30,mode
mov operand2,CX
jmp skipp
p2_BP2:
convrt_string_hex P2_regs+30,mode
mov operand2,CX
jmp skipp

ahb2:
;Creating Command String
mov SI,offset Lah
mov DI,offset commandString
add DI,cmndStringLength
mov cx,2
rep MOVSB
add cmndStringLength,2

cmp Player_turn,1   ;Player_turn = 0 if it's P1's Player_turn , Player_turn =1 if it's P2's Player_turn
jz p2_AH2
mov mode,2
convrt_string_hex P1_regs-2,mode ;; me7tageen ne8ayar P1_regs 3ala 7asab meen first operand P1_regs+5,10,15
mov operand2,CX
jmp skipp
p2_AH2:
mov mode,2
convrt_string_hex P2_regs-2,mode
mov operand2,CX
jmp skipp

alb2:
;Creating Command String
mov SI,offset Lah
mov DI,offset commandString
add DI,cmndStringLength
mov cx,2
rep MOVSB
add cmndStringLength,2

cmp Player_turn,1   ;Player_turn = 0 if it's P1's Player_turn , Player_turn =1 if it's P2's Player_turn
jz p2_AL2
mov mode,2
convrt_string_hex P1_regs,mode ;; me7tageen ne8ayar P1_regs 3ala 7asab meen first operand P1_regs+5,10,15
mov operand2,CX ; '0000'
jmp skipp
p2_AL2:
mov mode,2
convrt_string_hex P2_regs,mode
mov operand2,CX
jmp skipp

bhb2:
;Creating Command String
mov SI,offset Lbh
mov DI,offset commandString
add DI,cmndStringLength
mov cx,2
rep MOVSB
add cmndStringLength,2

cmp Player_turn,1   ;Player_turn = 0 if it's P1's Player_turn , Player_turn =1 if it's P2's Player_turn
jz p2_BH2
mov mode,2
convrt_string_hex P1_regs+3,mode ;; me7tageen ne8ayar P1_regs 3ala 7asab meen first operand P1_regs+5,10,15
mov operand2,CX
jmp skipp
p2_BH2:
mov mode,2
convrt_string_hex P2_regs+3,mode
mov operand2,CX
jmp skipp

blb2:
;Creating Command String
mov SI,offset Lbl
mov DI,offset commandString
add DI,cmndStringLength
mov cx,2
rep MOVSB
add cmndStringLength,2

cmp Player_turn,1   ;Player_turn = 0 if it's P1's Player_turn , Player_turn =1 if it's P2's Player_turn
jz p2_BL2
mov mode,2
convrt_string_hex P1_regs+5,mode ;; me7tageen ne8ayar P1_regs 3ala 7asab meen first operand P1_regs+5,10,15
mov operand2,CX
jmp skipp
p2_BL2:
mov mode,2
convrt_string_hex P2_regs+5,mode
mov operand2,CX
jmp skipp

chb2:
;Creating Command String
mov SI,offset Lch
mov DI,offset commandString
add DI,cmndStringLength
mov cx,2
rep MOVSB
add cmndStringLength,2

cmp Player_turn,1   ;Player_turn = 0 if it's P1's Player_turn , Player_turn =1 if it's P2's Player_turn
jz p2_CH2
mov mode,2
convrt_string_hex P1_regs+8,mode ;; me7tageen ne8ayar P1_regs 3ala 7asab meen first operand P1_regs+5,10,15
mov operand2,CX
jmp skipp
p2_CH2:
mov mode,2
convrt_string_hex P2_regs+8,mode
mov operand2,CX
jmp skipp

clb2:
;Creating Command String
mov SI,offset Lcl
mov DI,offset commandString
add DI,cmndStringLength
mov cx,2
rep MOVSB
add cmndStringLength,2

cmp Player_turn,1   ;Player_turn = 0 if it's P1's Player_turn , Player_turn =1 if it's P2's Player_turn
jz p2_CL2
mov mode,2
convrt_string_hex P1_regs+10,mode ;; me7tageen ne8ayar P1_regs 3ala 7asab meen first operand P1_regs+5,10,15
mov operand2,CX
jmp skipp
p2_CL2:
mov mode,2
convrt_string_hex P2_regs+10,mode
mov operand2,CX
jmp skipp

dhb2:
;Creating Command String
mov SI,offset Ldh
mov DI,offset commandString
add DI,cmndStringLength
mov cx,2
rep MOVSB
add cmndStringLength,2

cmp Player_turn,1   ;Player_turn = 0 if it's P1's Player_turn , Player_turn =1 if it's P2's Player_turn
jz p2_DH2
mov mode,2
convrt_string_hex P1_regs+13,mode ;; me7tageen ne8ayar P1_regs 3ala 7asab meen first operand P1_regs+5,10,15
mov operand2,CX
jmp skipp
p2_DH2:
mov mode,2
convrt_string_hex P2_regs+13,mode
mov operand2,CX
jmp skipp

dlb2:
;Creating Command String
mov SI,offset Ldl
mov DI,offset commandString
add DI,cmndStringLength
mov cx,2
rep MOVSB
add cmndStringLength,2

cmp Player_turn,1   ;Player_turn = 0 if it's P1's Player_turn , Player_turn =1 if it's P2's Player_turn
jz p2_DL2
mov mode,2
convrt_string_hex P1_regs+15,mode ;; me7tageen ne8ayar P1_regs 3ala 7asab meen first operand P1_regs+5,10,15
mov operand2,CX
jmp skipp
p2_DL2:
mov mode,2
convrt_string_hex P2_regs+15,mode
mov operand2,CX
jmp skipp

immediateaddb2:
call GetNumFromUser ; Value returns in CX ALways 'Must be edited'
cmp ReadUserSTR_syntaxErroFlag,1
je Errors
mov tempFrbd,CX
mov SI,offset ReadUserSTR_frbdn
mov DI,offset commandString
add DI,cmndStringLength
mov cx,ReadUserSTR_frbdn_Size
rep MOVSB
mov cx,ReadUserSTR_frbdn_Size
add cmndStringLength,CX
mov CX,tempFrbd
mov operand2,cx
jmp skipp

directaddb2:
Call DrawDSAddress
mov ah,0ch
mov al,0
int 21h
mov ah,0
int 16h
call GetbtnclickedDS
mov operand2_btn_DS,al
cmp ax,0ffffh
jz directaddb2 
cmp ax, 0 
jz add0_op2 
cmp ax, 1
jz add1_op2 
cmp ax, 2 
jz add2_op2
cmp ax, 3
jz add3_op2 
cmp ax, 4 
jz add4_op2
cmp ax, 5
jz add5_op2 
cmp ax, 6 
jz add6_op2
cmp ax, 7
jz add7_op2 
cmp ax, 8 
jz add8_op2

add0_op2: 
cmp Player_turn,1   ;Player_turn = 1 if it's P1's Player_turn , Player_turn =2 if it's P2's Player_turn
jz P2_add0_2
mov Player_num,1
mov DSAdd,0
Call GetDataSegmentValue   ;Now we got address 0 in cl and address 1 in ch
mov operand2,CX
jmp skipp
P2_add0_2:
mov Player_num,2
mov DSAdd,0
Call GetDataSegmentValue   ;Now we got address 0 in cl and address 1 in ch
mov operand2,CX
jmp skipp

add1_op2:
jmp add0_op2

add2_op2: 
cmp Player_turn,1   ;Player_turn = 1 if it's P1's Player_turn , Player_turn =2 if it's P2's Player_turn
jz P2_add2_2
mov Player_num,1
mov DSAdd,2
Call GetDataSegmentValue   ;Now we got address 2 in cl and address 3 in ch
mov operand2,CX
jmp skipp
P2_add2_2:
mov Player_num,2
mov DSAdd,2
Call GetDataSegmentValue   ;Now we got address 2 in cl and address 3 in ch
mov operand2,CX
jmp skipp

add3_op2:
jmp add2_op2

add4_op2: 
cmp Player_turn,1   ;Player_turn = 1 if it's P1's Player_turn , Player_turn =2 if it's P2's Player_turn
jz P2_add4_2
mov Player_num,1
mov DSAdd,4
Call GetDataSegmentValue   ;Now we got address 4 in cl and address 5 in ch
mov operand2,CX
jmp skipp
P2_add4_2:
mov Player_num,2
mov DSAdd,4
Call GetDataSegmentValue   ;Now we got address 4 in cl and address 5 in ch
mov operand2,CX
jmp skipp

add5_op2:
jmp add4_op2

add6_op2: 
cmp Player_turn,1   ;Player_turn = 1 if it's P1's Player_turn , Player_turn =2 if it's P2's Player_turn
jz P2_add6_2
mov Player_num,1
mov DSAdd,6
Call GetDataSegmentValue   ;Now we got address 6 in cl and address 7 in ch
mov operand2,CX
jmp skipp
P2_add6_2:
mov Player_num,2
mov DSAdd,6
Call GetDataSegmentValue   ;Now we got address 6 in cl and address 7 in ch
mov operand2,CX
jmp skipp

add7_op2:
jmp add6_op2

add8_op2: 
cmp Player_turn,1   ;Player_turn = 1 if it's P1's Player_turn , Player_turn =2 if it's P2's Player_turn
jz P2_add8_2
mov Player_num,1
mov DSAdd,8
Call GetDataSegmentValue   ;Now we got address 8 in cl and address 0 in ch (wrap around)
mov operand2,CX
jmp skipp
P2_add8_2:
mov Player_num,2
mov DSAdd,8
Call GetDataSegmentValue   ;Now we got address 8 in cl and address 0 in ch (wrap around)
mov operand2,CX
jmp skipp



; cmp Player_turn,1
; jz chckpw4p1
; jmp chckpw4p2

; chckpw4p1:
; cmp flagpower4_stuckbit_p2,1
; jz chckStuckp2


; jmp skipppw4

; chckpw4p2:

; skipppw4:
;;bxb2,cxb2.....

skipp:
;;:OPS;;;;
cmp OpBtn,0
jz Addition
cmp OpBtn,1
jz AddwithCarry
cmp OpBtn,2
jz Subtract
cmp OpBtn,3
jz SubwB
cmp OpBtn,4
jz Division
cmp OpBtn,5
jz Multiplication
cmp OpBtn,6
jz Xoring
cmp OpBtn,7
jz Anding
cmp OpBtn,8
jz Oring
cmp OpBtn,10
jz ShiftR
cmp OpBtn,11
jz ShiftL
cmp OpBtn,12
jz Move
cmp OpBtn,13
jz increment
cmp OpBtn,14
jz decrement
cmp OpBtn,16
jz IDivision
cmp OpBtn,17
jz IMultiplication
cmp OpBtn,18
jz RRot
cmp OpBtn,19
jz LRot



;---------------------------------------------------Addition----------------------------------------------------
Addition:
mov bp,cmndStringLength
mov SI,offset Ladd
mov DI,offset commandString
add DI,cmndStringLength
mov cx,3
rep MOVSB
add cmndStringLength,3

;Addition Validations ;; RegIndirect, direct addressing should be handled as well !!
cmp operand1_btn,17    ;Memory to memory error
jae chk_Op2_not_memory     
jmp skipMemoryErr
chk_Op2_not_memory:
cmp operand2_btn,17    
jae Errors
jmp skipE      ; leha lazma mahdsh yms7ha lw kamel mn gherha momkn ynot fel Errors

skipMemoryErr:
cmp operand1_btn,7
jbe chk_not_8bits
jmp chk_not_16bits

chk_not_8bits:
cmp operand2_btn,7
ja check_halfReg
jmp skipE
check_halfReg:
cmp operand2_btn,15
jbe Errors

chk_not_16bits:
cmp operand2_btn,7
jbe Errors

skipE:
jmp IsForbidden
AddFr:
cmp frbdncharflg,1
je Exit1

cmp operand1_btn,17
jae chk_byte_word
jmp check_when_op2IS_Add
chk_byte_word:
cmp operand2_btn,7
jbe take_word
mov modeDS,2     ;needed to update DS
cmp operand2_btn,16
jz chk_value
take_byte:
mov al,operand1_btn_DS
mov ah,0
mov dl,2
div dl    ;Decide what to take ch or cl by checking operand1_btn_DS is even or odd
cmp ah,0
je take_clOnly
jmp take_chOnly
take_clOnly:
mov ax,operand1
mov ah,0
mov bx,operand2
jmp do_add
take_chOnly:
mov ax,operand1 
mov al,ah   ;swap to take ch only from the operand , note: if mov al,0 this will not work properly
mov ah,0
mov bx,operand2
jmp do_add

chk_value:
cmp operand2,00FFH
jbe take_byte
jmp take_word

check_when_op2IS_Add:
cmp operand2_btn,17
jae chk_byte_word1
jmp take_word
chk_byte_word1:
cmp operand1_btn,7
jbe take_word
take_byte1:
mov al,operand2_btn_DS
mov ah,0
mov dl,2
div dl    ;Decide what to take ch or cl by checking operand2_btn_DS is even or odd
cmp ah,0
je take_clOnly1
jmp take_chOnly1
take_clOnly1:
mov ax,operand2
mov ah,0
mov bx,operand1
jmp do_add
take_chOnly1:
mov ax,operand2 
mov al,ah   ;swap to take ch only from the operand , note: if mov al,0 this will not work properly
mov ah,0
mov bx,operand1
jmp do_add


take_word:
mov ax,operand1
mov bx,operand2
mov modeDS,1   ;needed for updating DS

do_add:
add ax,bx
mov temp_DS,ax  ;;;-
cmp Player_turn,1
je changein2
jmp changein1

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
AddwithCarry:
mov bp,cmndStringLength
mov SI,offset Ladc
mov DI,offset commandString
add DI,cmndStringLength
mov cx,3
rep MOVSB
add cmndStringLength,3

;Addition Validations ;; RegIndirect, direct addressing should be handled as well !!
cmp operand1_btn,7
jbe chk_not_8bits1
jmp chk_not_16bits1

chk_not_8bits1:
cmp operand2_btn,7
ja check_halfReg1
jmp skipE1
check_halfReg1:
cmp operand2_btn,15
jbe Errors

chk_not_16bits1:
cmp operand2_btn,7
jbe Errors

skipE1:
jmp IsForbidden
AdcFr:
cmp frbdncharflg,1
je Exit1

mov ax,operand1
mov bx,operand2
adc ax,bx
cmp Player_turn,1
je changein2
jmp changein1
jmp Exit1
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Subtract:
mov bp,cmndStringLength
mov SI,offset Lsub
mov DI,offset commandString
add DI,cmndStringLength
mov cx,3
rep MOVSB
add cmndStringLength,3

cmp operand1_btn,7
jbe chk_not_8bits2
jmp chk_not_16bits2

chk_not_8bits2:
cmp operand2_btn,7
ja check_halfReg2
jmp skipE2
check_halfReg2:
cmp operand2_btn,15
jbe Errors

chk_not_16bits2:
cmp operand2_btn,7
jbe Errors

skipE2:
jmp IsForbidden
SubFr:
cmp frbdncharflg,1
je Exit1

mov ax,operand1
mov bx,operand2
sub ax,bx
cmp Player_turn,1
je changein2
jmp changein1
jmp Exit1

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SubwB:
mov bp,cmndStringLength
mov SI,offset Lsbb
mov DI,offset commandString
add DI,cmndStringLength
mov cx,3
rep MOVSB
add cmndStringLength,3

cmp operand1_btn,7
jbe chk_not_8bits3
jmp chk_not_16bits3

chk_not_8bits3:
cmp operand2_btn,7
ja check_halfReg3
jmp skipE3
check_halfReg3:
cmp operand2_btn,15
jbe Errors

chk_not_16bits3:
cmp operand2_btn,7
jbe Errors

skipE3:
jmp IsForbidden
SbbFr:
cmp frbdncharflg,1
je Exit1

mov ax,operand1
mov bx,operand2
sbb ax,bx
cmp Player_turn,1
je changein2
jmp changein1
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Xoring:
mov bp,cmndStringLength
mov SI,offset Lxor
mov DI,offset commandString
add DI,cmndStringLength
mov cx,3
rep MOVSB
add cmndStringLength,3

cmp operand1_btn,7
jbe chk_not_8bits6
jmp chk_not_16bits6

chk_not_8bits6:
cmp operand2_btn,7
ja check_halfReg6
jmp skipE6
check_halfReg6:
cmp operand2_btn,15
jbe Errors

chk_not_16bits6:
cmp operand2_btn,7
jbe Errors

skipE6:
jmp IsForbidden
XorFr:
cmp frbdncharflg,1
je Exit1

mov ax,operand1
mov bx,operand2
xor ax,bx
cmp Player_turn,1
je changein2
jmp changein1
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Anding:
mov bp,cmndStringLength
mov SI,offset Land
mov DI,offset commandString
add DI,cmndStringLength
mov cx,3
rep MOVSB
add cmndStringLength,3

cmp operand1_btn,7
jbe chk_not_8bits7
jmp chk_not_16bits7

chk_not_8bits7:
cmp operand2_btn,7
ja check_halfReg7
jmp skipE7
check_halfReg7:
cmp operand2_btn,15
jbe Errors

chk_not_16bits7:
cmp operand2_btn,7
jbe Errors

skipE7:
jmp IsForbidden
AndFr:
cmp frbdncharflg,1
je Exit1

mov ax,operand1
mov bx,operand2
and ax,bx
cmp Player_turn,1
je changein2
jmp changein1
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Oring:
mov bp,cmndStringLength
mov SI,offset Lor
mov DI,offset commandString
add DI,cmndStringLength
mov cx,2
rep MOVSB
add cmndStringLength,3

cmp operand1_btn,7
jbe chk_not_8bits8
jmp chk_not_16bits8

chk_not_8bits8:
cmp operand2_btn,7
ja check_halfReg8
jmp skipE8
check_halfReg8:
cmp operand2_btn,15
jbe Errors

chk_not_16bits8:
cmp operand2_btn,7
jbe Errors

skipE8:
jmp IsForbidden
OrFr:
cmp frbdncharflg,1
je Exit1

mov ax,operand1
mov bx,operand2
or ax,bx
cmp Player_turn,1
je changein2
jmp changein1
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LRot:
mov bp,cmndStringLength
mov SI,offset Lrol
mov DI,offset commandString
add DI,cmndStringLength
mov cx,3
rep MOVSB
add cmndStringLength,3

;LRot Validations ;; RegIndirect, direct addressing should be handled as well !!
cmp operand1_btn,16
jb chk_rol_cond
jmp Errors

chk_rol_cond:
cmp operand2_btn,16 ;(immediate)
je cond_rol_true

cmp operand2_btn,13 ;(CL)
jne Errors

cond_rol_true:

;bet0_31:
cmp operand2,32
jae Errors
jmp IsForbidden
RolFr:
cmp frbdncharflg,1
je Exit1

mov ax,operand1
mov cx,operand2
rol ax,cl
cmp Player_turn,1
je changein2
jmp changein1
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
RRot:
mov bp,cmndStringLength
mov SI,offset Lror
mov DI,offset commandString
add DI,cmndStringLength
mov cx,3
rep MOVSB
add cmndStringLength,3

;LRot Validations ;; RegIndirect, direct addressing should be handled as well !!
cmp operand1_btn,16
jb chk_ror_cond
jmp Errors

chk_ror_cond:
cmp operand2_btn,16 ;(immediate)
je cond_ror_true

cmp operand2_btn,13 ;(CL)
jne Errors

cond_ror_true:

;bet0_31:
cmp operand2,32
jae Errors
jmp IsForbidden
RorFr:
cmp frbdncharflg,1
je Exit1

mov ax,operand1
mov cx,operand2
ror ax,cl
cmp Player_turn,1
je changein2
jmp changein1
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ShiftR:
mov bp,cmndStringLength
mov SI,offset Lshr
mov DI,offset commandString
add DI,cmndStringLength
mov cx,3
rep MOVSB
add cmndStringLength,3

cmp operand1_btn,16
jb chk_shr_cond
jmp Errors

chk_shr_cond:
cmp operand2_btn,16 ;(immediate)
je cond_shr_true

cmp operand2_btn,13 ;(CL)
jne Errors

cond_shr_true:

;bet0_31:
cmp operand2,32
jae Errors
jmp IsForbidden
ShrFr:
cmp frbdncharflg,1
je Exit1

mov ax,operand1
mov cx,operand2
shr ax,cl
cmp Player_turn,1
je changein2
jmp changein1
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ShiftL:
mov bp,cmndStringLength
mov SI,offset Lshl
mov DI,offset commandString
add DI,cmndStringLength
mov cx,3
rep MOVSB
add cmndStringLength,3

cmp operand1_btn,16
jb chk_shl_cond
jmp Errors

chk_shl_cond:
cmp operand2_btn,16 ;(immediate)
je cond_shl_true

cmp operand2_btn,13 ;(CL)
jne Errors

cond_shl_true:

;bet0_31:
cmp operand2,32
jae Errors
jmp IsForbidden
ShlFr:
cmp frbdncharflg,1
je Exit1
mov ax,operand1
mov cx,operand2
shl ax,cl
cmp Player_turn,1
je changein2
jmp changein1
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;-------------------------------------------------Division-----------------------------------------------
Division:
mov bp,cmndStringLength
mov SI,offset Ldiv
mov DI,offset commandString
add DI,cmndStringLength
mov cx,3
rep MOVSB
add cmndStringLength,3
jmp IsForbidden
DivFr:
cmp frbdncharflg,1
je Exit1
cmp operand1,0h   ;Division by zero error
jz Errors
cmp operand1_btn,7h
jbe STbitdiv
Div_check_halfReg:
cmp operand1_btn,16h
ja AddressingMode2
;;;;;;;;;8 Bit Mul;;;;;;;;;
Ebitdiv:
cmp Player_turn,1
je Echangein2_4
jmp Echangein1_4

Echangein2_4:
mov mode,1           ;To div With AX
convrt_string_hex P2_regs,mode
mov ax,cx
mov bx,operand1
mov bh,0
div bl
mov reg_num,0h      ;AH will be the Remainder, and AL will be the Quotient
mov p_num,2h
call UpdateRegValue
jmp Exit1

Echangein1_4:
mov mode,1 ;To div With AX
convrt_string_hex P1_regs,mode
mov ax,cx
mov bx,operand1
mov bh,0
div bl
mov reg_num,0h      
mov p_num,1h
call UpdateRegValue
jmp Exit1
;;;;;;;; 16 Bit Mul ;;;;;;;;;
STbitdiv:
cmp Player_turn,1
je STchangein2_4
jmp STchangein1_4

STchangein2_4:
mov mode,1           ;To div With AX
convrt_string_hex P2_regs,mode
mov ax,cx
mov bx,operand1
div bx
mov Temp_Mul,dx
mov reg_num,0h      
mov p_num,2h
call UpdateRegValue
mov ax,Temp_Mul
mov reg_num,3h      
mov p_num,2h
call UpdateRegValue
jmp Exit1

STchangein1_4:
mov mode,1           ;To div With AX
convrt_string_hex P1_regs,mode
mov ax,cx
mov bx,operand1
div bx
mov Temp_Mul,dx
mov reg_num,0h      ;AH will be the Remainder, and AL will be the Quotient
mov p_num,1h
call UpdateRegValue
mov ax,Temp_Mul
mov reg_num,3h      ;AH will be the Remainder, and AL will be the Quotient
mov p_num,1h
call UpdateRegValue
jmp Exit1
AddressingMode2:
;----------------------------------------------Multiplication--------------------------------------------
Multiplication:
mov bp,cmndStringLength
mov SI,offset Lmul
mov DI,offset commandString
add DI,cmndStringLength
mov cx,3
rep MOVSB
add cmndStringLength,3
jmp IsForbidden
MulFr:
cmp frbdncharflg,1
je Exit1
cmp operand1_btn,7h
jbe STbitmul
Mul_check_halfReg:
cmp operand1_btn,16h
ja AddressingMode
;;;;;;;;;8 Bit Mul;;;;;;;;;
Ebitmul:
cmp Player_turn,1
je Echangein25
jmp Echangein15

Echangein25:
mov mode,1           ;To mul With AX
convrt_string_hex P2_regs,mode
mov ax,cx
mov bx,operand1
mov bh,0
mul bl
mov reg_num,0h      ;AH will be the Remainder, and AL will be the Quotient
mov p_num,2h
call UpdateRegValue
jmp Exit1

Echangein15:
mov mode,1 ;To mul With AX
convrt_string_hex P1_regs,mode
mov ax,cx
mov bx,operand1
mov bh,0
mul bl
mov reg_num,0h      
mov p_num,1h
call UpdateRegValue
jmp Exit1
;;;;;;;; 16 Bit Mul ;;;;;;;;;
STbitmul:
cmp Player_turn,1
je STchangein25
jmp STchangein15

STchangein25:
mov mode,1           ;To mul With AX
convrt_string_hex P2_regs,mode
mov ax,cx
mov bx,operand1
mul bx
mov Temp_Mul,dx
mov reg_num,0h      
mov p_num,2h
call UpdateRegValue
mov ax,Temp_Mul
mov reg_num,3h     
mov p_num,2h
call UpdateRegValue
jmp Exit1

STchangein15:
mov mode,1           ;To mul With AX
convrt_string_hex P1_regs,mode
mov ax,cx
mov bx,operand1
mul bx
mov Temp_Mul,dx
mov reg_num,0h     
mov p_num,1h
call UpdateRegValue
mov ax,Temp_Mul
mov reg_num,3h     
mov p_num,1h
call UpdateRegValue
jmp Exit1
AddressingMode:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;----------------------------------------------------IDivision-----------------------------------------------
IDivision:
mov bp,cmndStringLength
mov SI,offset Lidiv
mov DI,offset commandString
add DI,cmndStringLength
mov cx,4
rep MOVSB
add cmndStringLength,3
jmp IsForbidden
IdivFr:
cmp frbdncharflg,1
je Exit1
cmp operand1,0h   ;Division by zero error
jz Errors
cmp operand1_btn,7h
jbe STbitIdiv
IDiv_check_halfReg:
cmp operand1_btn,16h
ja AddressingMode3
;;;;;;;;;8 Bit Mul;;;;;;;;;
EbitIdiv:
cmp Player_turn,1
je Echangein2_16
jmp Echangein1_16

Echangein2_16:
mov mode,1           ;To idiv With AX
convrt_string_hex P2_regs,mode
mov ax,cx
mov bx,operand1
mov bh,0
Idiv bl
mov reg_num,0h     
mov p_num,2h
call UpdateRegValue
jmp Exit1

Echangein1_16:
mov mode,1 ;To idiv With AX
convrt_string_hex P1_regs,mode
mov ax,cx
mov bx,operand1
mov bh,0
Idiv bl
mov reg_num,0h     
mov p_num,1h
call UpdateRegValue
jmp Exit1
;;;;;;;; 16 Bit Mul ;;;;;;;;;
STbitIdiv:
cmp Player_turn,1
je STchangein2_16
jmp STchangein1_16

STchangein2_16:
mov mode,1           ;To idiv With AX
convrt_string_hex P2_regs,mode
mov ax,cx
mov bx,operand1
Idiv bx
mov Temp_Mul,dx
mov reg_num,0h     
mov p_num,2h
call UpdateRegValue
mov ax,Temp_Mul
mov reg_num,3h     
mov p_num,2h
call UpdateRegValue
jmp Exit1

STchangein1_16:
mov mode,1           ;To idiv With AX
convrt_string_hex P1_regs,mode
mov ax,cx
mov bx,operand1
Idiv bx
mov Temp_Mul,dx
mov reg_num,0h     
mov p_num,1h
call UpdateRegValue
mov ax,Temp_Mul
mov reg_num,3h     
mov p_num,1h
call UpdateRegValue
jmp Exit1
AddressingMode3:
;--------------------------------------------------IMultiplication-------------------------------------------
IMultiplication:
mov bp,cmndStringLength
mov SI,offset Limul
mov DI,offset commandString
add DI,cmndStringLength
mov cx,4
rep MOVSB
add cmndStringLength,3
jmp IsForbidden
ImulFr:
cmp frbdncharflg,1
je Exit1
cmp operand1_btn,7h
jbe STbitImul
IMul_check_halfReg:
cmp operand1_btn,16h
ja AddressingMode1
;;;;;;;;;8 Bit Mul;;;;;;;;;
EbitImul:
cmp Player_turn,1
je Echangein2_17
jmp Echangein1_17

Echangein2_17:
mov mode,1           ;To mul With AX
convrt_string_hex P2_regs,mode
mov ax,cx
mov bx,operand1
mov bh,0
Imul bl
mov reg_num,0h     
mov p_num,2h
call UpdateRegValue
jmp Exit1

Echangein1_17:
mov mode,1 ;To mul With AX
convrt_string_hex P1_regs,mode
mov ax,cx
mov bx,operand1
mov bh,0
Imul bl
mov reg_num,0h     
mov p_num,1h
call UpdateRegValue
jmp Exit1
;;;;;;;; 16 Bit Mul ;;;;;;;;;
STbitImul:
cmp Player_turn,1
je STchangein2_17
jmp STchangein1_17

STchangein2_17:
mov mode,1           ;To mul With AX
convrt_string_hex P2_regs,mode
mov ax,cx
mov bx,operand1
Imul bx
mov Temp_Mul,dx
mov reg_num,0h     
mov p_num,2h
call UpdateRegValue
mov ax,Temp_Mul
mov reg_num,3h     
mov p_num,2h
call UpdateRegValue
jmp Exit1

STchangein1_17:
mov mode,1           ;To mul With AX
convrt_string_hex P1_regs,mode
mov ax,cx
mov bx,operand1
Imul bx
mov Temp_Mul,dx
mov reg_num,0h     
mov p_num,1h
call UpdateRegValue
mov ax,Temp_Mul
mov reg_num,3h     
mov p_num,1h
call UpdateRegValue
jmp Exit1
AddressingMode1:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Move:
mov bp,cmndStringLength
mov SI,offset Lmov
mov DI,offset commandString
add DI,cmndStringLength
mov cx,3
rep MOVSB
add cmndStringLength,3

;Move Validations ;; RegIndirect, direct addressing should be handled as well !!
cmp operand1_btn,7
jbe chk_not_8bits12
jmp chk_not_16bits12

chk_not_8bits12:
cmp operand2_btn,7
ja check_halfReg12
jmp skipE12
check_halfReg12:
cmp operand2_btn,15
jbe Errors

chk_not_16bits12:
cmp operand2_btn,7
jbe Errors

skipE12:
jmp IsForbidden
MovFr:
cmp frbdncharflg,1
je Exit1

mov ax,operand1
mov bx,operand2
mov ax,bx
cmp Player_turn,1
je changein2
jmp changein1
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
increment:
mov bp,cmndStringLength
mov SI,offset Linc
mov DI,offset commandString
add DI,cmndStringLength
mov cx,3
rep MOVSB
add cmndStringLength,3

jmp IsForbidden
IncFr:
cmp frbdncharflg,1
je Exit1
;No need for validations, if operand1 is value,it is already handled in lines 46,47
mov ax,operand1
inc ax
cmp Player_turn,1
je changein2
jmp changein1

decrement:
mov bp,cmndStringLength
mov SI,offset Ldec
mov DI,offset commandString
add DI,cmndStringLength
mov cx,3
rep MOVSB
add cmndStringLength,3
;No need for validations, if operand1 is value,it is already handled in lines 46,47
jmp IsForbidden
DecFr:
cmp frbdncharflg,1
je Exit1
mov ax,operand1
dec ax
cmp Player_turn,1
je changein2
jmp changein1

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
IsForbidden:
cmp flagpower1_own,1
jz change_player_frbdn
jmp Not_change_player_frbdn
change_player_frbdn:
cmp Player_turn,2
jz selectfrchp22
jmp selectfrchp11
selectfrchp22:
mov al,P2_FrbdnChar+2
jmp skipselectfr
selectfrchp11:
mov al,P1_FrbdnChar+2
jmp skipselectfr

Not_change_player_frbdn:

cmp Player_turn,1
jz selectfrchp2
jmp selectfrchp1
selectfrchp2:
mov al,P2_FrbdnChar+2
jmp skipselectfr
selectfrchp1:
mov al,P1_FrbdnChar+2

skipselectfr:
mov DI,offset commandString
mov cx,cmndStringLength
REPNE SCASB
jz setfrbdFlag
jmp skipfrbd
setfrbdFlag:
mov frbdncharflg,1
jmp skipfrbcheck
skipfrbd:
mov frbdncharflg,0
skipfrbcheck:


cmp OpBtn,0
jz AddFr
cmp OpBtn,1
jz AdcFr
cmp OpBtn,2
jz SubFr
cmp OpBtn,3
jz SbbFr
cmp OpBtn,4
jz DivFr
cmp OpBtn,5
jz MulFr
cmp OpBtn,6
jz XorFr
cmp OpBtn,7
jz AndFr
cmp OpBtn,8
jz OrFr
cmp OpBtn,10
jz ShrFr
cmp OpBtn,11
jz ShlFr
cmp OpBtn,12
jz MovFr
cmp OpBtn,13
jz IncFr
cmp OpBtn,14
jz DecFr
cmp OpBtn,16
jz IdivFr
cmp OpBtn,17
jz ImulFr
cmp OpBtn,18
jz RorFr
cmp OpBtn,19
jz RolFr


changein2:
cmp flagpower2_ownandopponent,1
jz change_both
cmp operand1_btn,17
jae updateDS
mov bh,operand1_btn
mov reg_num,bh
mov p_num,2h
call UpdateRegValue 
jmp Exit1
changein1:
cmp flagpower2_ownandopponent,1
jz change_both
cmp operand1_btn,17
jae updateDS
mov bh,operand1_btn
mov reg_num,bh
mov p_num,1h
call UpdateRegValue
jmp Exit1


change_both:
cmp operand1_btn,17
jae updateBoth_DS
jmp updateBoth_Reg
updateBoth_DS:
mov ax,temp_DS
mov Player_num,1h
Call UpdateDataSegmentValue
mov Player_num,2h
Call UpdateDataSegmentValue
jmp Exit1
updateBoth_Reg:
mov tempPW,ax
mov bh,operand1_btn
mov reg_num,bh 
mov p_num,1h
call UpdateRegValue
mov ax,tempPW
mov bh,operand1_btn
mov reg_num,bh
mov p_num,2h
call UpdateRegValue
jmp Exit1



updateDS:
mov ax,temp_DS
cmp Player_turn,1
je changein2_DS
mov Player_num,1h
Call UpdateDataSegmentValue
jmp Exit1
changein2_DS:
mov Player_num,2h
Call UpdateDataSegmentValue
jmp Exit1


Errors:
cmp Player_turn,1
je p1mistake
jmp p2mistake
p1mistake:
mov points_inc_index,1
mov points_inc_value,1
DecrementPoints points_inc_index,points_inc_value
jmp Exit1
p2mistake:
mov points_inc_index,2
mov points_inc_value,1
DecrementPoints points_inc_index,points_inc_value
Exit1:
; mov ah,2
; mov dl,1   ;X-position
; mov dh,3   ;Y-position
; int 10h
; mov ah,9
; mov dx,offset commandString
; int 21h
mov cx,cmndStringLength
mov si,offset resetcmdStr
mov di,offset commandString
rep movsb
mov cmndStringLength,0
mov frbdncharflg,0

cmp flagpower1_own,1 ;;change the turn back to the 1st state
jz activate_pw1_end
jmp skippw_end
activate_pw1_end:
    cmp Player_turn,2
    je chng_turn1_end
    jmp chng_turn22_end
    chng_turn1_end:
    mov Player_turn,1
    jmp skippw_end
    chng_turn22_end:
    mov Player_turn,2
skippw_end:
call Pwrups_resetflag
ENDM Ops