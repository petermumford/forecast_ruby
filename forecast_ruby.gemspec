# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'forecast_ruby/version'

Gem::Specification.new do |spec|
  spec.name          = "forecast_ruby"
  spec.version       = ForecastRuby::VERSION
  spec.authors       = ["Peter Mumford"]
  spec.email         = ["peter@petermumford.com"]
  spec.description   = %q{Ruby gem for forecast.io, gets current conditions, todays and the next seven days}
  spec.summary       = %q{Ruby gem for forecast.io}
  spec.homepage      = "https://github.com/petermumford/forecast_ruby"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.required_ruby_version = '>= 1.8.7'

  spec.add_dependency 'httparty'
  spec.add_dependency 'hashie'

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
