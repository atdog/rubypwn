# rubypwn
Ruby - pwn tools 

### How to install

```
$ gem install rubypwn

$ irb
2.2.2 :001 > require 'rubypwn'
 => true
2.2.2 :002 > e = Exec.new "ls -la"
 => #<Exec:0x007fdf32e6f320>
2.2.2 :003 > e.gets
total 16
 => "total 16\n"
2.2.2 :004 > Asm.compile("mov eax, 1")
 => "b801000000"
2.2.2 :005 >
```
