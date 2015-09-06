class Elf
====================================

Used to get some constant value from the binary::

    2.2.2 :001 > require 'pp'
    2.2.2 :001 > require 'rubypwn'
     => true
    2.2.2 :002 > e = Elf.new "traveller"
    2.2.2 :003 > pp Elf.new "traveller"
    #<Elf:0x007fdd23c3b510
     @arch="x86",
     @bits=32,
     @dynamic=
      {"strtab"=>134513496,
       "symtab"=>134513160,
       "rel_type"=>"REL",
       "jmprel"=>134513844},
     @global={"__gmon_start__"=>{"offset"=>134521192, "value"=>0}},
     @got=
      {"__errno_location"=>134521208,
       "sigemptyset"=>134521212,
       "getpid"=>134521216,
       "__gmon_start__"=>134521220,
       "__isoc99_sscanf"=>134521224,
       "fgets"=>134521228,
       "__libc_start_main"=>134521232,
       "sigaltstack"=>134521236,
       "siglongjmp"=>134521240,
       "sigaction"=>134521244,
       "strlen"=>134521248,
       "printf"=>134521252,
       "setvbuf"=>134521256,
       "puts"=>134521260,
       "kill"=>134521264,
       "__sigsetjmp"=>134521268,
       "exit"=>134521272}>
    2.2.2 :007 > puts "%08x" % e.got['kill']
    0804a1b0
