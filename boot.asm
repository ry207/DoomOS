org 0x7c00
bits 16

%define ENDL 0x0D, 0x0A

mov ax, 0x3     ;clear scree
int 10h         ;clear screen pt2



mov ah, 0x0e
mov bx, message

info:
    ;inc al          ;increment al (i = 65 i++)
    ;cmp al, 90 + 1  ;compare whats in al (65/a) with 90/z
    ;je exit         ;jump if equal to the exit label
    ;int 0x10        ;interupt
    ;jmp loop        ;go back to loop until the je is activated

    mov al, [bx]    ;move bx (mov bx, name) to the al register
    cmp al, 0       ;comapre al to 0, if zero that means its a null character and string is over
    je space        ;if equal to 0 then go to the exit label
    int 0x10        ;interrupt
    inc bx          ;inx bx so the pos in the string increases
    jmp info



;new line
space:
    pop bx
    pop ax
    mov ah, 0x0e
    mov al, 13
    int 0x10
    mov ah, 0x0e
    mov al, 0AH
    int 0x10
    mov ah, 0x0e
    mov bx, name
    jmp printname

infobuff:
    mov ah, 0x0e
    mov bx, message
    jmp info

text_color_green:
    mov ah,00h      ; Set video mode
    mov al,03h      ; Mode 3 (Color text)
    int 10h
    mov ax, 0600h        ; AH=06(scroll up window), AL=00(entire window)
    mov bh, 20h    ; left nibble for background (blue), right nibble for foreground (light gray)
    mov cx, 0000h        ; CH=00(top), CL=00(left)
    ;mov dx, 1010h        ; DH=19(bottom), DL=50(right)
    mov dh, 19h
    mov dl, 50h
    int 10h
    jmp infobuff


bgcolor_blue:
    mov ah,00h      ; Set video mode
    mov al,03h      ; Mode 3 (Color text)
    int 10h
    mov ax, 0600h        ; AH=06(scroll up window), AL=00(entire window)
    mov bh, 17h    ; left nibble for background (blue), right nibble for foreground (light gray)
    mov cx, 0000h        ; CH=00(top), CL=00(left)
    ;mov dx, 1010h        ; DH=19(bottom), DL=50(right)
    mov dh, 19h
    mov dl, 50h
    int 10h
    jmp infobuff

;prints DoomOS
printname:
    ;inc al          ;increment al (i = 65 i++)
    ;cmp al, 90 + 1  ;compare whats in al (65/a) with 90/z
    ;je exit         ;jump if equal to the exit label
    ;int 0x10        ;interupt
    ;jmp loop        ;go back to loop until the je is activated
    mov al, [bx]    ;move bx (mov bx, name) to the al register
    cmp al, 0       ;comapre al to 0, if zero that means its a null character and string is over
    je arrow         ;if equal to 0 then go to the exit label
    int 0x10        ;interrupt
    inc bx          ;inx bx so the pos in the string increases
    jmp printname


;print arrow ---->
arrow:
    mov ah, 0x0e
    mov al, 45
    int 0x10
    mov ah, 0x0e
    mov al, '>'
    int 0x10
    jmp loop3



;loop for getting input
;want to change to string collection to check for commands
loop3:
    mov ah, 0x0     ;get key
    int 16h

    cmp al, 45      ;the - key prints new screen
    je newscreen

    cmp al, 13      ;enter keys goes new line
    je space

    cmp al, 63      ;? keys shows commands
    je commands1

    cmp al, 42      ;* key goes to title print
    je spacerbuff


    cmp al, 126
    je text_color_green ;~ key changes bg color to blue

    cmp al, 35
    je bgcolor_blue


    cmp al, 27
    je exit

    cmp al, 8
    je delete

    mov ah, 0xE     ;display character
    int 10h

    jmp loop3


    cli
    hlt

commands1:
    mov ah, 0x0e
    mov bx, clear_command
    jmp clearcom


spacerbuff:
    mov ah, 0x0e
    mov bx, spacertext
    jmp spacer

spacer:
    mov al, [bx]    ;move bx (mov bx, name) to the al register
    cmp al, 0       ;comapre al to 0, if zero that means its a null character and string is over
    je pt1buff         ;if equal to 0 then go to the exit label
    int 0x10        ;interrupt
    inc bx          ;inx bx so the pos in the string increases
    jmp spacer

pt1buff:
    mov ah, 0x0e
    mov bx, doomos1
    jmp print_title1

print_title1:
    mov al, [bx]    ;move bx (mov bx, name) to the al register
    cmp al, 0       ;comapre al to 0, if zero that means its a null character and string is over
    je pt2buff         ;if equal to 0 then go to the exit label
    int 0x10        ;interrupt
    inc bx          ;inx bx so the pos in the string increases
    jmp print_title1

pt2buff:
    mov ah, 0x0e
    mov bx, doomos2
    jmp print_title2

print_title2:
    mov al, [bx]    ;move bx (mov bx, name) to the al register
    cmp al, 0       ;comapre al to 0, if zero that means its a null character and string is over
    je pt3buff         ;if equal to 0 then go to the exit label
    int 0x10        ;interrupt
    inc bx          ;inx bx so the pos in the string increases
    jmp print_title2

pt3buff:
    mov ah, 0x0e
    mov bx, doomos3
    jmp print_title3

print_title3:
    mov al, [bx]    ;move bx (mov bx, name) to the al register
    cmp al, 0       ;comapre al to 0, if zero that means its a null character and string is over
    je pt4buff         ;if equal to 0 then go to the exit label
    int 0x10        ;interrupt
    inc bx          ;inx bx so the pos in the string increases
    jmp print_title3

pt4buff:
    mov ah, 0x0e
    mov bx, doomos4
    jmp print_title4

print_title4:
    mov al, [bx]    ;move bx (mov bx, name) to the al register
    cmp al, 0       ;comapre al to 0, if zero that means its a null character and string is over
    je space         ;if equal to 0 then go to the exit label
    int 0x10        ;interrupt
    inc bx          ;inx bx so the pos in the string increases
    jmp print_title4


clearcom:
    mov al, [bx]    ;move bx (mov bx, name) to the al register
    cmp al, 0       ;comapre al to 0, if zero that means its a null character and string is over
    je space         ;if equal to 0 then go to the exit label
    int 0x10        ;interrupt
    inc bx          ;inx bx so the pos in the string increases
    jmp clearcom

;new screen when the - key is clicked
newscreen:
    mov ax, 0x3
    int 10h
    jmp infobuff

delete:
    mov ah, 0x0e
    mov al, 8
    int 0x10
    mov ah, 0x0e
    mov al, 32
    int 0x10
    mov ah, 0x0e
    mov al, 8
    int 0x10
    jmp loop3

exit:
    popa

    pop di
    pop dx
    pop cx
    pop bx
    pop ax                             ; restore registers modified
    ret

buffer:
    times 10 db 0
    mov bx, buffer


;commands
clear_command: db "[-] clears the screen [~]&[#] changes bgcolors [*] prints the title", 0


message: db "Type ? for a list of commands",ENDL, 0
name: db "DoomOS", 0

;doomos title

spacertext: db " ", ENDL, 0
doomos1: db "==========", ENDL, 0
doomos2: db "| DoomOS |", ENDL, 0
doomos3: db "==========", ENDL, 0

doomos4: db "Welcome to DoomOS!", ENDL, 0

times 510-($-$$) db 0
dw 0AA55h
