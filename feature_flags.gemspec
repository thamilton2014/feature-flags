
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "feature-flags/version"

Gem::Specification.new do |spec|
  spec.name          = "feature-flags"
  spec.version       = FeatureFlags::VERSION
  spec.authors       = ["thamilton"]
  spec.email         = ["thamilton@rsglab.com"]

  spec.summary       = %q{Summary example}
  spec.description   = %q{Description example}
  spec.homepage      = "https://www.google.com"
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
end
