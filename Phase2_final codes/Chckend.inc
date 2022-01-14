CheckEndGame Macro 
    local check2ndbit,skipcheckzero,player2_won,check2ndbit2,skipcheckzero2,player1_won,exit_endgame

    cmp P1_init_points+2,30h 
    jz check2ndbit
    jmp skipcheckzero
    check2ndbit:
    cmp P1_init_points+3,30h 
    jz player2_won
    skipcheckzero:
    cmp P2_init_points+2,30h 
    jz check2ndbit2
    jmp skipcheckzero2
    check2ndbit2:
    cmp P2_init_points+3,30h 
    jz player1_won
    skipcheckzero2:
    ;----------------------------
    
    mov dh,0
    mov dl,5
 
    ;check player1
    cmpstr endgame_value,P1_regs,dx
    jz player2_won
 
    cmpstr endgame_value,P1_regs[5],dx
    jz player2_won
 
    cmpstr endgame_value,P1_regs[10],dx
    jz player2_won
 
    cmpstr endgame_value,P1_regs[15],dx
    jz player2_won
 
    cmpstr endgame_value,P1_regs[20],dx
    jz player2_won
 
    cmpstr endgame_value,P1_regs[25],dx
    jz player2_won
 
    cmpstr endgame_value,P1_regs[30],dx
    jz player2_won
 
    cmpstr endgame_value,P1_regs[35],dx
    jz player2_won
 
 
    ;check player2
 
    cmpstr endgame_value,P2_regs,dx
    jz player1_won
 
    cmpstr endgame_value,P2_regs[5],dx
    jz player1_won
 
    cmpstr endgame_value,P2_regs[10],dx
    jz player1_won
 
    cmpstr endgame_value,P2_regs[15],dx
    jz player1_won
 
    cmpstr endgame_value,P2_regs[20],dx
    jz player1_won
 
    cmpstr endgame_value,P2_regs[25],dx
    jz player1_won
 
    cmpstr endgame_value,P2_regs[30],dx
    jz player1_won
 
    cmpstr endgame_value,P2_regs[35],dx
    jz player1_won
 
    jmp exit_endgame
    ;----------------------------
    player1_won:
    mov Player_win,1
    jmp exit_endgame
 
    player2_won:
    mov Player_win,2
    jmp exit_endgame
 
    exit_endgame:
 
endm CheckEndGame 