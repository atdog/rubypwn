Useful Function
====================================

* **def i64()** ::

    2.2.2 :004 > a = 0x1234567890abcdef
     => 1311768467294899695
    2.2.2 :005 > i64 a
     => "\xEF\xCD\xAB\x90xV4\x12"


* **def i32()**
* **def i16()**
* **def s64()**
* **def s32()** ::

    2.2.2 :004 > a = "\x30\x00\x00\x00"
     => "0\u0000\u0000\u0000"
    2.2.2 :005 > s32 a
     => 48


* **def s16()**
* **def c()** ::

    2.2.2 :004 > a = 3
     => 3
    2.2.2 :005 > c a
     => "\x03"


* **def hex()** ::

    2.2.2 :002 > a = "test"
     => "test"
    2.2.2 :003 > hex a
     => "74657374"


* **def nop()** ::

    2.2.2 :002 > nop
     => "\x90"


