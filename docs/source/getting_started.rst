Getting Started
====================================

Installation
------------------------

::

    gem install rubypwn
    


Basic Usage
------------------------

class Exec ::

    2.2.2 :002 > e = Exec.new "ls"
     => #<Exec:0x007f96742814e8>
    2.2.2 :003 > e.gets
    Makefile
     => "Makefile\n"

class Netcat ::

    2.2.2 :004 > e = Netcat.new "www.google.com", 80
     => #<Netcat:0x007f9671a00cf8>
    2.2.2 :005 > e.puts "GET / HTTP/1.1"
    GET / HTTP/1.1
     => #<IO:fd 12>
    2.2.2 :006 > e.puts
     => #<IO:fd 12>
    2.2.2 :008 > e.gets
    HTTP/1.1 302 Found
     => "HTTP/1.1 302 Found\r\n"

