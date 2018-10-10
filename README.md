## compile

nasm -fmacho64 -g BssSection.asm

gcc BssSection.o

## debug

https://stackoverflow.com/questions/36803989/assembly-unable-to-set-breakpoints-lldb

lldb a.out

br s -a 0x100000fb4 ; set breakpoint

## lldb command

https://lldb.llvm.org/lldb-gdb.html

### read content of registers

register read
