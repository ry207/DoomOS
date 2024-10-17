Basic operating system with keyboard shortcut commands 

To boot, in the DoomOS Dir, type:
```
nasm -f bin boot.asm -o boot.bin
```
then...
```
qemu-system-x86_64 boot.bin
```
And it should boot up!


There is no bootloader or kernel, none of it is programmed in c, just assembly
planning on adding a bootloader and all that at some point

Thanks youtube:eprograms for the inspiration ly
