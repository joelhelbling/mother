lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "mother/version"

Gem::Specification.new do |spec|
  spec.name = "mother"
  spec.version = Mother::VERSION
  spec.authors = ["Joel Helbling"]
  spec.email = ["joel@joelhelbling.com"]

  spec.summary = "Method-ized access to a hash's children, and their children."
  spec.description = "Ever wish you had effortless, JS-like access to a deeply nested yaml?"
  spec.homepage = "https://mother.joelhelbling.com"
  spec.license = "MIT"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path("..", __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.3.15"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.11"
  spec.add_development_dependency "rspec-given", "~> 3.8"
  spec.add_development_dependency "fakefs", "1.8"
  spec.add_development_dependency "pry"
end
