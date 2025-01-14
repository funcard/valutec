# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'valutec/version'

Gem::Specification.new do |spec|
  spec.name          = "valutec"
  spec.version       = Valutec::VERSION
  spec.authors       = ["Nikky Southerland"]
  spec.email         = ["nikky@ricksteves.com"]
  spec.summary       = %q{Provides a wrapper to the Valutec Transaction API}
  spec.description   = %q{Partial implementation of Valutec Transaction API.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "webmock"

  spec.add_development_dependency "guard"
  spec.add_development_dependency "guard-rspec"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "pry-remote"
  spec.add_development_dependency "pry-nav"

  spec.add_dependency "httparty"
end
