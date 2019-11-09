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

## dif of mov and lea

https://stackoverflow.com/questions/1699748/what-is-the-difference-between-mov-and-lea


reference

http://flint.cs.yale.edu/cs421/papers/x86-asm/asm.html
https://cs.lmu.edu/~ray/notes/nasmtutorial/
https://eli.thegreenplace.net/2011/09/06/stack-frame-layout-on-x86-64/
