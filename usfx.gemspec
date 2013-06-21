Gem::Specification.new do |s|
  s.name         = "usfx"
  s.version      = "0.1.3"
  s.author       = "Tim Morgan"
  s.email        = "tim@timmorgan.org"
  s.homepage     = "https://github.com/seven1m/usfx"
  s.summary      = "Ruby stream parser for Unified Scripture Format XML (USFX)"
  s.files        = %w(README.md) + Dir['lib/**/*'].to_a
  s.require_path = "lib"
  s.has_rdoc     = true
  s.add_dependency("nokogiri", ">= 1.6.0")
end
