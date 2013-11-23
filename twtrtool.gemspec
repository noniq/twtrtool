lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'twtrtool/version'

Gem::Specification.new do |spec|
  spec.name          = "twtrtool"
  spec.version       = Twtrtool::VERSION
  spec.authors       = ["Stefan Daschek"]
  spec.email         = ["stefan@daschek.net"]
  spec.summary       = %q{twtrtool is a small command line utility helping you to manage your Twitter lists.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  
  spec.add_dependency "thor", "~> 0.18.1"
  spec.add_dependency "twitter", "~> 4.8.1"
end
