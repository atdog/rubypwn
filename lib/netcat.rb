require_relative 'exec'

class Netcat < Exec
    def initialize(ip, port)
        super("nc #{ip} #{port}")
    end
end
