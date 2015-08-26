Gem::Specification.new do |s|
  s.name        = 'rubypwn'
  s.version     = '0.0.4'
  s.date        = '2015-08-26'
  s.summary     = "pwn tools - ruby version"
  s.description = "pwn tools"
  s.authors     = ["atdog"]
  s.email       = 'atdog.tw@gmail.com'
  s.files         = `git ls-files`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  s.homepage    = 'https://github.com/atdog/rubypwn/'
  s.license     = 'MIT'
end
