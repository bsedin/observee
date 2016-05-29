# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'observee/version'

Gem::Specification.new do |spec|
  spec.name          = "observee"
  spec.version       = Observee::VERSION
  spec.authors       = ["Sergey Besedin"]
  spec.email         = ["kr3ssh@gmail.com"]

  spec.summary       = %q{Webserver availability monitoring tool}
  spec.description   = ''
  spec.homepage      = "https://github.com/kressh/observee"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "celluloid", "~> 0.17.3"
  spec.add_dependency "net-ping", "~> 1.7.8"
  spec.add_dependency "thor", '~> 0.19.1'
  spec.add_dependency "timers", '~> 4.1.1'
  spec.add_dependency "hitimes", '~> 1.2.3'

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "pry", "~> 0.10.3"
end
