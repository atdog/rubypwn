patch_alarm
====================================

Patch alarm() to isnan().

How to use? ::
    
    $ cat test.c && make test
    #include <unistd.h>
    main() {
        alarm(0);
    }
    cc     test.c   -o test

    $ patch_alarm ./test
    Done.

    $ patch_alarm ./test.patch
    No "alarm" found.

    $ ltrace ./test.patch
    __libc_start_main(0x40052d, 1, 0x7ffe3ca9a1b8, 0x400540 <unfinished ...>
    isnan(0, 0x7ffe3ca9a1b8, 0x7ffe3ca9a1c8, 0)                                                      = 0
    +++ exited (status 0) +++
