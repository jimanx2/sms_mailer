$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "sms_mailer/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "sms_mailer"
  s.version     = SmsMailer::VERSION
  s.authors     = ["Haziman Hashim"]
  s.email       = ["haziman@abh.my"]
  s.homepage    = "http://www.abh.my"
  s.summary     = "Define your own SMS delivery method for your rails' app."
  s.description = "This gem let you create custom SMS delivery method so that your rails app can interface via local SMS gateway's API. Predefined provider: ['isms']"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.5.1"
end
