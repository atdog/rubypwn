class Elf
====================================

Used to get some constant value from the binary::

    2.2.0 :001 > require 'rubypwn'
     => true
    2.2.0 :002 > e = Elf.new "/lib/i386-linux-gnu/libc.so.6"
    2.2.0 :003 > e.gotplt.keys
     => ["_Unwind_Find_FDE", "realloc", "malloc", "memalign", "_dl_find_dso_for_object", "calloc", "___tls_get_addr", "free", ""]
    2.2.0 :004 > e.gotplt["malloc"]
     => 1744916
    2.2.0 :005 > puts "%08x" % e.gotplt["malloc"]
    001aa014
