

Gem::Specification.new do |s|
  s.name        = "lemonlime"
  s.version     = "0.0.1"
  s.author      = "Pete Brousalis"
  s.email       = "brousapg@gmail.com"
  s.summary     = "Gem for spriting images and outputting mixins"
  s.description = "Gem for spriting mixins and outputting mixins. Built ontop of sprite-factory"
  s.homepage    = "http://github.com/brousalis/lemonlime/"

  s.add_runtime_dependency 'sprite-factory', '~> 1.6.2'
  s.add_runtime_dependency 'paintbucket'

  s.files           = `git ls-files`.split($\)
  s.require_paths   = ['lib']
end
