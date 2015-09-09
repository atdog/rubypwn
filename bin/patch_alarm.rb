#!/usr/bin/env ruby
#
require 'rubypwn'

if __FILE__ == $0
    if ARGV.size != 1
        puts "%s binary" % $0
    end
    filename = ARGV[0]

    e = Elf.new filename
    pp e.sections[".dynstr"]
end
