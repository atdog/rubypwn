class Asm
====================================

Used to compile assembly code ::

    2.2.3 :004 > Asm.compile "push eax"
     => "50"
    2.2.3 :005 > Asm.compile "push rax", arch: "amd64"
     => "50"
    2.2.3 :012 > Asm.compile "mov r15, r14", arch: "arm", format: "c"
     => "\\x0e\\xf0\\xa0\\xe1"

