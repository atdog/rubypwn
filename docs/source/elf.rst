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
      {""=>{"addr"=>0, "offset"=>0, "size"=>0, "flag"=>"r--"},
       ".interp"=>{"addr"=>134512948, "offset"=>308, "size"=>19, "flag"=>"r--"},
       ".note.ABI-tag"=>
        {"addr"=>134512968, "offset"=>328, "size"=>32, "flag"=>"r--"},
       ".hash"=>{"addr"=>134513000, "offset"=>360, "size"=>160, "flag"=>"r--"},
       ".dynsym"=>{"addr"=>134513160, "offset"=>520, "size"=>336, "flag"=>"r--"},
       ".dynstr"=>{"addr"=>134513496, "offset"=>856, "size"=>232, "flag"=>"r--"},
       ".gnu.version"=>
        {"addr"=>134513728, "offset"=>1088, "size"=>42, "flag"=>"r--"},
       ".gnu.version_r"=>
        {"addr"=>134513772, "offset"=>1132, "size"=>48, "flag"=>"r--"},
       ".rel.dyn"=>{"addr"=>134513820, "offset"=>1180, "size"=>24, "flag"=>"r--"},
       ".rel.plt"=>{"addr"=>134513844, "offset"=>1204, "size"=>136, "flag"=>"r--"},
       ".init"=>{"addr"=>134513980, "offset"=>1340, "size"=>48, "flag"=>"r-x"},
       ".plt"=>{"addr"=>134514028, "offset"=>1388, "size"=>288, "flag"=>"r-x"},
       ".text"=>{"addr"=>134514320, "offset"=>1680, "size"=>1612, "flag"=>"r-x"},
       ".fini"=>{"addr"=>134515932, "offset"=>3292, "size"=>28, "flag"=>"r-x"},
       ".rodata"=>{"addr"=>134515960, "offset"=>3320, "size"=>445, "flag"=>"r--"},
       ".eh_frame_hdr"=>
        {"addr"=>134516408, "offset"=>3768, "size"=>100, "flag"=>"r--"},
       ".eh_frame"=>
        {"addr"=>134516508, "offset"=>3868, "size"=>368, "flag"=>"r--"},
       ".ctors"=>{"addr"=>134520972, "offset"=>4236, "size"=>8, "flag"=>"rw-"},
       ".dtors"=>{"addr"=>134520980, "offset"=>4244, "size"=>8, "flag"=>"rw-"},
       ".jcr"=>{"addr"=>134520988, "offset"=>4252, "size"=>4, "flag"=>"rw-"},
       ".dynamic"=>{"addr"=>134520992, "offset"=>4256, "size"=>200, "flag"=>"rw-"},
       ".got"=>{"addr"=>134521192, "offset"=>4456, "size"=>4, "flag"=>"rw-"},
       ".got.plt"=>{"addr"=>134521196, "offset"=>4460, "size"=>80, "flag"=>"rw-"},
       ".data"=>{"addr"=>134521276, "offset"=>4540, "size"=>8, "flag"=>"rw-"},
       ".bss"=>{"addr"=>134521312, "offset"=>4548, "size"=>16812, "flag"=>"rw-"},
       ".comment"=>{"addr"=>0, "offset"=>4548, "size"=>61, "flag"=>"r--"},
       ".shstrtab"=>{"addr"=>0, "offset"=>4609, "size"=>213, "flag"=>"r--"}}>
