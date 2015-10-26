Format String
====================================

Basic Usage
------------------------

String Ext ::

    2.2.3 :001 > require 'rubypwn'
     => true
    2.2.3 :002 > str = "prefix_str_"
     => "prefix_str_"
    2.2.3 :003 > str.fmtstr
    str.fmtstr
    2.2.3 :003 > str.fmtstr i32(0x601808), 10, bytes: 2
     => "prefix_str_%6152c%10$hn%59480c%11$hn"
    2.2.3 :004 > str.fmtstr "system", 12, bytes: 2
     => "prefix_str_%6152c%10$hn%59480c%11$hn%30995c%12$hn%64256c%13$hn%63730c%14$hn"
    2.2.3 :005 > "test".fmtstr i64(0x3121), 1, fmt_size: 100
     => "test%189c%1$hhn%16c%2$hhn%207c%3$hhn%4$hhn%5$hhn%6$hhn%7$hhn%8$hhn"
