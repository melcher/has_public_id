$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "has_public_id/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "has_public_id"
  s.version     = HasPublicId::VERSION
  s.authors     = ["Graham Melcher"]
  s.email       = ["melcher@gmail.com"]
  s.homepage    = "https://github.com/hinthealth/has_public_id"
  s.summary     = "Random, unique identifiers for activerecord models"
  s.description = "Allows for the easy creation and use of random, unique record identifiers so external entities cannot make inferences about your data based on sequential ID's"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.licenses    = ['MIT']
  s.add_dependency "activerecord", ">= 4.0", "<= 5.1"

  s.add_development_dependency "sqlite3"
end
