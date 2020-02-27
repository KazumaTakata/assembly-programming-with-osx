
## command

nasm -fmacho64 -g main.asm
gcc main.o
./a.out



## osx assembly

It seems that the gcc linker in macOS doesn’t allow absolute addressing unless you tweak some settings. So add default rel when you are referencing labeled memory locations, and always use lea to get your addresses

the 16-bit stack alignment requirement is enforced. 

[source](https://cs.lmu.edu/~ray/notes/nasmtutorial/)

