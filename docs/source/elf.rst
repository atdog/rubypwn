class Elf
====================================

Used to get some constant value from the binary::

    2.2.2 :001 > require 'pp'
    2.2.2 :002 > require 'rubypwn'
     => true
    2.2.2 :003 > e = Elf.new "traveller"
    2.2.2 :004 > pp e
    #<Elf:0x007fb498862550
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
       "exit"=>134521272},
     @sections=
      {""=>{"offset"=>0, "flag"=>"r--"},
       ".interp"=>{"offset"=>134512948, "flag"=>"r--"},
       ".note.ABI-tag"=>{"offset"=>134512968, "flag"=>"r--"},
       ".hash"=>{"offset"=>134513000, "flag"=>"r--"},
       ".dynsym"=>{"offset"=>134513160, "flag"=>"r--"},
       ".dynstr"=>{"offset"=>134513496, "flag"=>"r--"},
       ".gnu.version"=>{"offset"=>134513728, "flag"=>"r--"},
       ".gnu.version_r"=>{"offset"=>134513772, "flag"=>"r--"},
       ".rel.dyn"=>{"offset"=>134513820, "flag"=>"r--"},
       ".rel.plt"=>{"offset"=>134513844, "flag"=>"r--"},
       ".init"=>{"offset"=>134513980, "flag"=>"r-x"},
       ".plt"=>{"offset"=>134514028, "flag"=>"r-x"},
       ".text"=>{"offset"=>134514320, "flag"=>"r-x"},
       ".fini"=>{"offset"=>134515932, "flag"=>"r-x"},
       ".rodata"=>{"offset"=>134515960, "flag"=>"r--"},
       ".eh_frame_hdr"=>{"offset"=>134516408, "flag"=>"r--"},
       ".eh_frame"=>{"offset"=>134516508, "flag"=>"r--"},
       ".ctors"=>{"offset"=>134520972, "flag"=>"rw-"},
       ".dtors"=>{"offset"=>134520980, "flag"=>"rw-"},
       ".jcr"=>{"offset"=>134520988, "flag"=>"rw-"},
       ".dynamic"=>{"offset"=>134520992, "flag"=>"rw-"},
       ".got"=>{"offset"=>134521192, "flag"=>"rw-"},
       ".got.plt"=>{"offset"=>134521196, "flag"=>"rw-"},
       ".data"=>{"offset"=>134521276, "flag"=>"rw-"},
       ".bss"=>{"offset"=>134521312, "flag"=>"rw-"},
       ".comment"=>{"offset"=>0, "flag"=>"r--"},
       ".shstrtab"=>{"offset"=>0, "flag"=>"r--"}}>
