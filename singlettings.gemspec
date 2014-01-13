# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'singlettings/version'

Gem::Specification.new do |spec|
  spec.name          = "singlettings"
  spec.version       = Singlettings::VERSION
  spec.authors       = ["Jingkai He"]
  spec.email         = ["jaxihe@gmail.com"]
  spec.description   = %q{A simple YML to singleton class solution for ruby programming language.}
  spec.summary       = %q{A simple YML to singleton class solution for ruby programming language.}
  spec.homepage      = "https://github.com/mycolorway/singlettings"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  # spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
