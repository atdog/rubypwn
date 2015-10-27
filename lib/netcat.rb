require_relative 'exec'

class Netcat < Exec
    def initialize(ip, port, **options)
        super("nc #{ip} #{port}", options)
    end
end
