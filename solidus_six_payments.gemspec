$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "solidus_six_payments/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "solidus_six_payments"
  s.version     = SolidusSixPayments::VERSION
  s.authors     = ["Felix Langenegger"]
  s.email       = ["felix.langenegger@fadendaten.ch"]
  s.homepage    = "http://fadendaten.ch"
  s.summary     = "Summary of SolidusSixPayments."
  s.description = "Description of SolidusSixPayments."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.1.0"
  s.add_dependency 'solidus', ['>= 2.0', '< 3']

  s.add_dependency 'sqlite3'

  # s.add_development_dependency "sqlite3"
end
