# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ryonan/version'

Gem::Specification.new do |spec|
  spec.name          = 'ryonan'
  spec.version       = Ryonan::VERSION
  spec.authors       = ['tigberd']
  spec.email         = ['tigberd@gmail.com']

  spec.summary       = 'Ryonan is a tool to make simple skeleton'
  spec.description   = 'Ryonan is a tool to make simple skeleton. It make from template directory and erb, and interactively operation.'
  spec.homepage      = 'https://github.com/tigberd/ryonan'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'activesupport', '~> 4.2'
  spec.add_development_dependency 'bundler', '~> 1.8'
  spec.add_development_dependency 'rake', '~> 10.0'
end
