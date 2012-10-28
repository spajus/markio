# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'markio/version'

Gem::Specification.new do |gem|
  gem.name          = "markio"
  gem.version       = Markio::VERSION
  gem.authors       = ["Tomas Varaneckas"]
  gem.email         = ["tomas.varaneckas@gmail.com"]
  gem.description   = %q{Import/export utility for Netscape Bookmark Format}
  gem.summary       = %q{Import/export utility for Netscape Bookmark Format}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'nokogiri'
  gem.add_development_dependency 'rspec', '~> 2.11'
  gem.add_development_dependency 'pry-nav'
  gem.add_development_dependency 'guard-rspec'

end
