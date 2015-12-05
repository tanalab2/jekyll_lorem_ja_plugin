# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'jekyll_lorem_ja_plugin/version'

Gem::Specification.new do |spec|
  spec.name          = "jekyll_lorem_ja_plugin"
  spec.version       = JekyllLoremJaPlugin::VERSION
  spec.authors       = ["tanaken2"]

  spec.summary       = %q{Yet Another Japanese Lorem Ipsum generator For Jekyll}
  spec.description   = %q{Yet Another Japanese Lorem Ipsum generator For Jekyll}
  spec.homepage      = "https://github.com/tanalab2/jekyll_lorem_ja_plugin"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"

  spec.add_runtime_dependency("ya_lorem_ja", ">= 0.0.5")
end
