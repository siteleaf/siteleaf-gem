# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'siteleaf/version'

Gem::Specification.new do |gem|
  gem.name          = "siteleaf"
  gem.version       = Siteleaf::VERSION
  gem.license       = "MIT"
  gem.authors       = ["Siteleaf"]
  gem.email         = ["api@siteleaf.com"]
  gem.description   = %q{A Ruby interface and command line utility for the Siteleaf API.}
  gem.summary       = "Siteleaf Ruby interface"
  gem.homepage      = "http://siteleaf.com"

  gem.required_ruby_version = '>= 1.9.3'

  gem.add_dependency 'httparty', '>= 0.14.0'
  gem.add_dependency 'httmultiparty', '>= 0.3.13'
  gem.add_dependency 'psych', '>= 2.0.17'
  gem.add_dependency 'rack'

  gem.files         = `git ls-files`.split($/)
  gem.files         += Dir.glob("lib/**/*.rb")
  gem.executables   = ["siteleaf"]
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
