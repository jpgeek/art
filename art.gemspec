$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "art/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "art"
  s.version     = Art::VERSION
  s.authors     = ["Steve Brown"]
  s.email       = ["steve@zergsoft.com"]
  s.homepage    = "https://github.com/jpgeek/art"
  s.summary     = "A simple translation library for ActiveRecord models"
  s.description = "A siple translation library for ActiveRecord models, relying only on public interfaces of AR and i18n."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.0.2"

  s.add_development_dependency "sqlite3"
end
