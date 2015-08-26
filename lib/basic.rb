def i16(int)
    [int].pack("S<")
end

def i32(int)
    [int].pack("L<")
end

def i64(int)
    [int].pack("Q<")
end

def s16(int)
    str = str.ljust(2, "\x00")
    str.unpack("S<")[0]
end

def s32(str)
    str = str.ljust(4, "\x00")
    str.unpack("L<")[0]
end

def s64(str)
    str = str.ljust(8, "\x00")
    str.unpack("Q<")[0]
end

def c(int)
    [int].pack("C")
end

def hex(str)
    str.unpack("H*")[0]
end

def nop()
    "\x90"
end
