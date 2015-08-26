require 'rest-client'
require 'json'
require 'base64'

class Asm
    # Supported Format: hex, c, binary
    def self.compile(code, arch="i386", format="hex")
        r = RestClient.post 'http://atdog.tw/asm/compile', :code => code, :arch => arch, :format => format
        r = JSON.parse r
        if r['result'] == 1
            if format == "binary"
                return Base64.decode64(r['code'])
            else
                return r['code']
            end
        else
            raise "asm compile error. [code]: #{code}"
        end
    end
end
