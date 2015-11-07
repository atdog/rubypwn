class String

    def ^( key )
        b1 = self.unpack("C*")
        b2 = key.unpack("C*")
        mul = (b1.length.to_f / b2.length.to_f).ceil
        b2 = b2 * mul
        b1.zip(b2).map{ |a,b| a^b }.pack("C*")
    end

    def fmtstr(value, index, **options)
        # initialize
        bytes = 1
        @fmt_size = 0 unless defined? @fmt_size
        # set by user input
        bytes = options[:bytes] if options.has_key? :bytes
        @fmt_size = options[:fmt_size] if options.has_key? :fmt_size

        fail "Invalid size." if bytes == 3 or bytes > 4 or bytes == 0

        result = self
        times = (value.size / bytes.to_f).ceil

        times.times do
            target = fmtstr_parse value, bytes
            if (c = fmtstr_calc(@fmt_size, target, bytes)) > 0
                result << "%#{c}c"
                @fmt_size += c
            end
            result << "%#{index}$#{bytes == 4 ? "" : "h" * (3-bytes)}n"
            index += 1
            value = value[bytes..-1]
        end

        result
    end

    private
    def fmtstr_calc(from, to, scale)
        base = 256 ** scale

        count = 0
        count = to - (from % base)
        count += base if count < 0
        count
    end

    def fmtstr_parse(v, bytes)
        result = 0
        v = v.ljust bytes, "\x00"
        if bytes == 1
            result = v.unpack("C")[0]
        elsif bytes == 2
            result = v.unpack("S<")[0]
        elsif bytes == 4
            result = v.unpack("L<")[0]
        end
        result
    end
end
