# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'url_regex/version'

Gem::Specification.new do |spec|
  spec.name          = 'url_regex'
  spec.version       = UrlRegex::VERSION
  spec.authors       = ['Alexey Mogilnikov']
  spec.email         = ['alexey@mogilnikov.name']
  spec.summary       = 'Provides the best regex for validating or extracting URLs'
  spec.description   = ''
  spec.homepage      = 'https://github.com/amogil/url_regex'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rubocop'
end
