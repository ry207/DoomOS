org 0x7c00
bits 16


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

mov  cx, 1      ; ReplicationCount=1
mov  bx, 0024h  ; BH is DisplayPage=0, BL is ColorAttribute=24h (RedOnGreen)


mov ah, 0x0e
mov bx, name


;new line
space:
    mov ah, 0x0e
    mov al, 13
    int 0x10
    mov ah, 0x0e
    mov al, 0AH
    int 0x10
    mov ah, 0x0e
    mov bx, user
    jmp printuser

bgcolor:
    mov ah,00h      ; Set video mode
    mov al,03h      ; Mode 3 (Color text)
    int 10h
    mov ax, 0600h        ; AH=06(scroll up window), AL=00(entire window)
    mov bh, 00010111b    ; left nibble for background (blue), right nibble for foreground (light gray)
    mov cx, 0000h        ; CH=00(top), CL=00(left)
    ;mov dx, 1010h        ; DH=19(bottom), DL=50(right)
    mov dh, 19h
    mov dl, 50h
    int 10h
    jmp space


printuser:
    ;inc al          ;increment al (i = 65 i++)
    ;cmp al, 90 + 1  ;compare whats in al (65/a) with 90/z
    ;je exit         ;jump if equal to the exit label
    ;int 0x10        ;interupt
    ;jmp loop        ;go back to loop until the je is activated
    mov al, [bx]    ;move bx (mov bx, name) to the al register
    cmp al, 0       ;comapre al to 0, if zero that means its a null character and string is over
    je bsat         ;if equal to 0 then go to the exit label
    int 0x10        ;interrupt
    inc bx          ;inx bx so the pos in the string increases
    jmp printuser


;prints the @ symbol between user and DoomOS
bsat:
    mov ah, 0x0e
    mov al ,64
    int 0x10
    mov ah, 0x0e
    mov bx, name
    jmp printname



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
    mov al, 45
    int 0x10
    mov ah, 0x0e
    mov al, 45
    int 0x10
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

    cmp al, 126
    je bgcolor

    mov ah, 0xE     ;display character
    int 10h

    jmp loop3


    cli
    hlt

commands1:
    mov ah, 0x0e
    mov bx, clear_command
    jmp clearcom




clearcom:
    ;inc al          ;increment al (i = 65 i++)
    ;cmp al, 90 + 1  ;compare whats in al (65/a) with 90/z
    ;je exit         ;jump if equal to the exit label
    ;int 0x10        ;interupt
    ;jmp loop        ;go back to loop until the je is activated
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
    jmp space

exit:
    jmp $

buffer:
    times 10 db 0
    mov bx, buffer


;commands
clear_command: db "[-] clears the screen [~] changes background to blue", 0


message: db "Type ? for a list of commands", 0
name: db "DoomOS", 0
user: db "User", 0
times 510-($-$$) db 0
db 0x55, 0xaa
