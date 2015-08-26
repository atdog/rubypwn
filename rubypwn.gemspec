Gem::Specification.new do |s|
  s.name        = 'rubypwn'
  s.version     = '0.0.5'
  s.date        = '2015-08-26'
  s.summary     = "pwntools - ruby version"
  s.description   = <<-DESCRIPTION.strip.gsub(/\s+/, " ")
    A simple library for CTF pwning challegnges.
    Like Python's pwntools, it's used to help you write exploit quickly.
  DESCRIPTION
  s.authors     = ["Hung Chi Su"]
  s.email       = 'atdog.tw@gmail.com'
  s.files         = `git ls-files`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  s.homepage    = 'https://github.com/atdog/rubypwn/'
  s.license     = 'MIT'
end
