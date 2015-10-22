require 'open3'

class Exec
    public
    def initialize(cmd)
        handle_exception
        @i, @o, s = Open3.popen2(cmd)
    end

    def read(size)
        data = @o.read size
        write_flush $stdout, data
        data
    end

    def readpartial(size)
        data = @o.readpartial size
        write_flush $stdout, data
        data
    end

    def write(data)
        write_flush $stdout, data
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
                write_flush $stdout, result
                return result
            end
        end
    end

    def interactive
        loop do
            if @o.eof?
                puts "client disconnected."
                exit
            end
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
