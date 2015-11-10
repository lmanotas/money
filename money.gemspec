lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |s|
  s.name        = 'money'
  s.version     = '0.0.1'
  s.date        = '2015-11-10'
  s.summary     = "Money Conversions"
  s.description = "Use this gem to converts money currencies"
  s.authors     = ["Luis Manotas"]
  s.email       = 'lgerman@gmail.com'
  s.files       = ["lib/money.rb"]
  s.homepage    = 'http://rubygems.org/gems/money'
  s.license     = 'MIT'

  s.add_development_dependency "rake"
  s.add_development_dependency "rspec"
end