require 'open3'
require 'rainbow/ext/string'

class Exec
    attr_accessor :debug, :color

    public
    def initialize(cmd, **options)
        handle_exception
        @i, @o, s = Open3.popen2(cmd)
        # Debug msg
        @debug = (options.has_key? :debug) ? options[:debug] : true
        # Log color
        Rainbow.enabled = false if options[:color] == false
    end

    def read(size)
        @o.read(size).tap {|data| write_flush $stdout, data.color(:cyan) if @debug}
    end

    def readpartial(size)
        @o.readpartial(size).tap {|data| write_flush $stdout, data.color(:cyan) if @debug}
    end

    def write(data)
        data = data.to_s if data.is_a? Integer
        write_flush $stdout, data.color(:yellow) if @debug
        write_flush @i, data
    end

    def puts(data)
        write "#{data}\n"
    end

    def gets
        read_until "\n"
    end

    def read_until(str)
        result = ""
        loop do
            result << @o.read(1)
            if result.end_with? str
                write_flush $stdout, result if @debug
                return result
            end
        end
    end

    def interactive
        loop do
            r = IO.select [@o, $stdin]
            if r[0].include? @o
                read 1
            elsif r[0].include? $stdin
                @i.write $stdin.read(1)
            end
        end
    end

    private
    def write_flush(fd, data)
        fd.write data
        fd.flush
    end

    def handle_exception
        trap "SIGINT" do
            $stdout.puts
            $stdout.puts "interrupted"
            exit -1
        end
    end
end
