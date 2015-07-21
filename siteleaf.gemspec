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

  gem.add_dependency 'httparty', '>= 0.13.3'
  gem.add_dependency 'httmultiparty', '>= 0.3.13'
  gem.add_dependency 'rack'

  # Added for RSpec testing
  gem.add_development_dependency 'rspec'
  # To mock a fake web for HTTP requests
  gem.add_development_dependency 'webmock'
  # For code coverage analysis of RSpec
  gem.add_development_dependency 'simplecov'
  # For developers to adhere to codings standards
  gem.add_development_dependency 'rubocop'
  # For rake tasks
  gem.add_development_dependency 'rake'

  gem.files         = `git ls-files`.split($/)
  gem.files         += Dir.glob("lib/**/*.rb")
  gem.executables   = ["siteleaf"]
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
