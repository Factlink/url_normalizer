# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'url_normalizer/version'

Gem::Specification.new do |spec|
  spec.name          = "url_normalizer"
  spec.version       = UrlNormalizer::VERSION
  spec.authors       = ["Mark IJbema", "Martijn Russchen", "Tom de Vries"]
  spec.email         = ["markijbema+url_normalizer@gmail.com"]
  spec.description   = %q{Ruby gem to normalize urls}
  spec.summary       = %q{Ruby gem to normalize urls}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "andand"
  spec.add_dependency "addressable"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
