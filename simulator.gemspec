# -*- encoding: utf-8 -*-
require File.expand_path('../lib/simulator/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Jamie Ly"]
  gem.email         = ["me@jamie.ly"]
  gem.description   = %q{Use to simulate discrete time models. See the examples directory for examples.}
  gem.summary       = %q{Use to simulate discrete time models.}
  gem.homepage      = "http://github.com/jamiely/simulator"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "simulator"
  gem.require_paths = ["lib"]
  gem.version       = Simulator::VERSION

  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'cucumber'
end
