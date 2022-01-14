Update_P1ds MACRO
    
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


ENDM Update_P1ds