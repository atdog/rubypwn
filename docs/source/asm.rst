class Asm
====================================

Used to compile assembly code ::

    2.2.2 :002 > Asm.compile("mov eax, 1")
     => "b801000000"
    2.2.2 :003 > Asm.compile("mov rax, 1", "amd64", "c")
     => "\\x48\\xc7\\xc0\\x01\\x00\\x00\\x00"
    2.2.2 :004 > Asm.compile("mov r15, r14", "arm", "binary")
     => "\x0E\xF0\xA0\xE1"

