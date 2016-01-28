Gem::Specification.new do |s|
  s.name            = 'investment-tracking-domain'
  s.version         = '0.0.1'
  s.platform        = Gem::Platform::RUBY
  s.summary         = 'Domain model for investment tracking app.'
  s.description     = 'This is to be plugged into delivery mechanisms for the investment tracking app.'
  s.email           = 'thiago.rdp@gmail.com'
  s.authors         = ['Thiago Rodrigues de Paula']
  s.homepage        = 'https://github.com/thiagorp/investment-tracking-domain'
  s.license         = 'MIT'

  s.files           = `git ls-files`.split("\n")
  s.test_files      = `git ls-files -- test/*`.split("\n")
  s.require_paths   = ['lib', 'domain', 'application']
  s.required_ruby_version = '>= 2.3.0'

  s.add_development_dependency('rake', '~>10.5')
  s.add_development_dependency('minitest', '~> 5.8')
end
