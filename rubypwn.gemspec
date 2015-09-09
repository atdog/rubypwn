Gem::Specification.new do |s|
  s.name        = 'rubypwn'
  s.version     = '0.0.13'
  s.date        = '2015-09-09'
  s.summary     = "ruby pwn tools"
  s.description   = <<-DESCRIPTION.strip.gsub(/\s+/, " ")
    A simple library for CTF pwning challenges.
    Like Python's pwntools, it's used to help you write exploit quickly.
  DESCRIPTION
  s.authors     = ["atdog"]
  s.email       = 'atdog.tw@gmail.com'
  s.files         = `git ls-files`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  s.homepage    = 'https://github.com/atdog/rubypwn/'
  s.license     = 'MIT'
  s.add_runtime_dependency 'rainbow', '~> 2.0', '>= 2.0.0'
  s.add_runtime_dependency 'thread', '~> 0.2', '>= 0.2.2'
  s.add_runtime_dependency 'rest-client', '~> 1.8', '>= 1.8.0'
  s.add_runtime_dependency 'bindata', '~> 2.1', '>= 2.1.0'
end
