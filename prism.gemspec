# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'prism/version'

Gem::Specification.new do |spec|
  spec.name          = "prism"
  spec.version       = Prism::VERSION
  spec.authors       = ["lionelbarrow"]
  spec.email         = ["lionelbarrow@gmail.com"]
  spec.description   = "PRISM watches your calls. Method calls."
  spec.summary       = "PRISM watches your calls. Method calls."
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
