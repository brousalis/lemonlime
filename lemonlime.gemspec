Gem::Specification.new do |s|
  s.name        = "lemonlime"
  s.version     = "0.0.1"
  s.author      = "Pete Brousalis"
  s.email       = "brousapg@gmail.com"
  s.summary     = "Gem for spriting mixins" 
  s.description = "Gem for spriting mixins" 
  s.homepage    = "http://github.com/brousalis/lemonlime/"

  s.add_runtime_dependency 'sprite_factory'

  s.files           = `git ls-files`.split($\)
  s.require_paths   = ['lib']
end
