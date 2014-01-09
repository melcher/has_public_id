$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "public_id/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "public_id"
  s.version     = PublicId::VERSION
  s.authors     = ["Graham Melcher"]
  s.email       = ["melcher@gmail.com"]
  s.homepage    = "https://github.com/hinthealth/public_id"
  s.summary     = "Random, unique identifiers for activerecord models"
  s.description = "Allows for the easy creation and use of random, unique record identifiers so external entities cannot make inferences about your data based on sequential ID's"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.0.2"

  s.add_development_dependency "sqlite3"
end
