Pwrups MACRO pnum
    local powerup_1,powerup_2,powerup_3,powerup_4,powerup_5,player_2,skip_p2,assign_1num1,assign_1num2,player2_check3,execute_3,player2_check5,exit_pwrups_error
    
    push di
    push bx
    mov bh,0
    mov bx,pnum

    call GetNumFromUser

    push cx ;user chosen option

    cmp pnum,2
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
    jnz assign_1num2
    mov dl,2
    convrt_string_hex P2_init_points,dl
    jmp skip_assign2

    assign_1num2:
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

    mov points_inc_index,bl
    mov points_inc_value,5

    DecrementPoints points_inc_index,points_inc_value

    jmp exit_pwrups



    ;-----------------------
    powerup_2:

    cmp player_points,3
    jb exit_pwrups

    mov points_inc_index,bl
    mov points_inc_value,3

    DecrementPoints points_inc_index,points_inc_value

    mov flagpower2_ownandopponent,1

    jmp exit_pwrups

    ;-----------------------
    
    powerup_3:
    
    cmp player_points,8
    jb exit_pwrups


    cmp pnum,2
    jz player2_check3

    cmp flagpower3_changefbdn_p1,1

   
    jz exit_pwrups

    ;PUT YOUR CODE HERE AMINOZ------------------------


    ;-------------------------------------------------

    mov points_inc_index,bl
    mov points_inc_value,8

    DecrementPoints points_inc_index,points_inc_value

    mov flagpower3_changefbdn_p1,1
    jmp exit_pwrups


    player2_check3:

    ;PUT YOUR CODE HERE AMINOZ------------------------


    ;-------------------------------------------------
    cmp flagpower3_changefbdn_p2,1

    mov points_inc_index,bl
    mov points_inc_value,8

    DecrementPoints points_inc_index,points_inc_value

    mov flagpower3_changefbdn_p2,1
    jz exit_pwrups


    ;-----------------------
    powerup_4: ;VALUE IS RETURNED IN CX, bit stuck type in power4_stuckbitvalue

    ;NOTE: if bit type = 0, yeb2a (cx AND value) to force the bit to be zero
    ;      if bit type = 1, yeb2a (cx OR value)  to force the bit to be one


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



    mov points_inc_index,bl
    mov points_inc_value,2

    DecrementPoints points_inc_index,points_inc_value



    cmp power4_stuckbitvalue,1
    jz exit_pwrups

    not cx

    jmp exit_pwrups

    
    ;-------------------------------------


    powerup_5:

    cmp player_points,30
    jb exit_pwrups

    cmp pnum,2
    jz player2_check5

    cmp flagpower5_regclr_p1,1
    jz exit_pwrups

    push ax
    mov ax,0

    mov temp_reg_num,0
    UpdateRegValue pnum,temp_reg_num

    mov temp_reg_num,1
    UpdateRegValue pnum,temp_reg_num

    mov temp_reg_num,2
    UpdateRegValue pnum,temp_reg_num

    mov temp_reg_num,3
    UpdateRegValue pnum,temp_reg_num

    mov temp_reg_num,4
    UpdateRegValue pnum,temp_reg_num

    mov temp_reg_num,5
    UpdateRegValue pnum,temp_reg_num

    mov temp_reg_num,6
    UpdateRegValue pnum,temp_reg_num

    mov temp_reg_num,7
    UpdateRegValue pnum,temp_reg_num


    mov points_inc_index,bl
    mov points_inc_value,30d

    DecrementPoints points_inc_index,points_inc_value

    mov flagpower3_changefbdn_p1,1

    pop ax
    jmp exit_pwrups


    player2_check5:

    cmp flagpower5_regclr_p2,1
    jz exit_pwrups


    mov temp_reg_num,0
    UpdateRegValue pnum,temp_reg_num

    mov temp_reg_num,1
    UpdateRegValue pnum,temp_reg_num

    mov temp_reg_num,2
    UpdateRegValue pnum,temp_reg_num

    mov temp_reg_num,3
    UpdateRegValue pnum,temp_reg_num

    mov temp_reg_num,4
    UpdateRegValue pnum,temp_reg_num

    mov temp_reg_num,5
    UpdateRegValue pnum,temp_reg_num

    mov temp_reg_num,6
    UpdateRegValue pnum,temp_reg_num

    mov temp_reg_num,7
    UpdateRegValue pnum,temp_reg_num


    mov points_inc_index,bl
    mov points_inc_value,30
    

    DecrementPoints points_inc_index,points_inc_value

    mov flagpower5_regclr_p2,1
    
    pop ax
    jmp exit_pwrups



    exit_pwrups_error:
    mov powerup_error,1

    exit_pwrups:

    pop bx
    pop di
    
ENDM Pwrups



Pwrups_resetflag MACRO 
    
    mov flagpower1_own,0
    mov flagpower2_ownandopponent,0
    mov flagpower4_stuckbit,0

ENDM Pwrups_resetflag