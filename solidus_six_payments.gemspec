$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "solidus_six_payments/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = "solidus_six_payments"
  spec.version     = SolidusSixPayments::VERSION
  spec.authors     = ["Felix Langenegger"]
  spec.email       = ["felix.langenegger@fadendaten.ch"]
  spec.homepage    = "http://fadendaten.ch"
  spec.summary     = "Summary of SolidusSixPayments."
  spec.description = "Description of SolidusSixPayments."
  spec.license     = "MIT"

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "rails"#, "~> 5.1.0"
  spec.add_dependency 'solidus'#, ['>= 2.0', '< 3']

  spec.add_development_dependency "sqlite3", '~> 1.3.0'

  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.8"
  spec.add_development_dependency "rspec-rails", "~> 3.8"

  spec.add_development_dependency "rdoc", "~> 6.1"
  spec.add_development_dependency "vcr", "~> 4.0"
  spec.add_development_dependency "dotenv", "~> 2.7"
  spec.add_development_dependency 'pry', '~> 0.12'
end
