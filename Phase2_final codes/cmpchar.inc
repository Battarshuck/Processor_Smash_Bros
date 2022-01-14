cmpstr MACRO si_ptr,di_ptr,cx_val

    mov cx,cx_val

    mov si,offset si_ptr

    mov di,offset di_ptr

    repe cmpsb 
    
ENDM cmpstr
