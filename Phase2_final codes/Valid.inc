Valid_user_syntaxError  MACRO STR,STR_size
    local skip1,skip2,skip3,skip4,exit_syntaxErrorValidation,exit_NoError

    ;capitalize every letter
    cmp STR,61h
    jb skip1
    
    sub STR,20h
    
    skip1:
    
    cmp STR+1,61h
    jb skip2
    
    sub STR+1,20h
    
    skip2:
    
    cmp STR+2,61h
    jb skip3
    
    sub STR+2,20h
    
    skip3:
    
    cmp STR+3,61h
    jb skip4
    
    sub STR+3,20h
    
    skip4: 
    ;-------------
    ;checking for any invalid character
    ;NOTE: you need to move offset everytime 
    ;because 'REPNE' increments it automatically
    mov di,offset Valid_input

    mov al, STR
    mov cx,10h
    Repne scasb
    jnz exit_syntaxErrorValidation

    dec STR_size
    jz exit_NoError

    mov di,offset Valid_input

    mov al, STR+1
    mov cx,10h
    Repne scasb
    jnz exit_syntaxErrorValidation

    dec STR_size
    jz exit_NoError

    mov di,offset Valid_input

    mov al, STR+2
    mov cx,10h
    Repne scasb
    jnz exit_syntaxErrorValidation

    dec STR_size
    jz exit_NoError
    

    mov di,offset Valid_input

    mov al, STR+3
    mov cx,10h
    Repne scasb
    jnz exit_syntaxErrorValidation


    jmp exit_NoError
    
    exit_syntaxErrorValidation:
    mov ReadUserSTR_syntaxErroFlag,1

    exit_NoError:

ENDM Valid_user_syntaxError