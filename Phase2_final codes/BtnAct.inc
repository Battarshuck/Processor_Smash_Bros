BtnAct MACRO  
local exit
mov OpBtn,ax
cmp OpBtn,9
je exit
cmp OpBtn,15
je ClearCarry

call DrawAddressingRow
Ops btn_num
jmp exit
ClearCarry:
CLC

   exit: 
ENDM BtnAct