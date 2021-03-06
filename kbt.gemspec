
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "kbt/version"

Gem::Specification.new do |spec|
  spec.name          = "kbt"
  spec.version       = Kbt::VERSION
  spec.authors       = ["Artur Panyach"]
  spec.email         = ["arturictus@gmail.com"]

  spec.summary       = %q{Kubernetes templating engine for Ruby.}
  spec.description   = %q{Kubernetes templating engine for Ruby.}
  spec.homepage      = "https://github.com/arturictus/kbt"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_dependency "fusu"
end
