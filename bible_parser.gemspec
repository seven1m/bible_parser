Gem::Specification.new do |s|
  s.name         = "bible_parser"
  s.version      = "1.0.0"
  s.author       = "Tim Morgan"
  s.email        = "tim@timmorgan.org"
  s.homepage     = "https://github.com/seven1m/bible_parser"
  s.summary      = "Library for parsing the bible in various formats"
  s.files        = %w(README.md) + Dir['lib/**/*'].to_a
  s.require_path = "lib"
  s.has_rdoc     = true
  s.add_dependency("nokogiri", ">= 1.6.0")
  s.add_development_dependency("rspec", "3.2.0")
  s.add_development_dependency("pry")
end
