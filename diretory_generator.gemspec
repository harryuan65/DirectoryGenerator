# frozen_string_literal: true

require_relative "lib/diretory_generator/version"

Gem::Specification.new do |spec|
  spec.name = "diretory_generator"
  spec.version = DiretoryGenerator::VERSION
  spec.authors = ["harryuan65"]
  spec.email = ["harryuan.65@gmail.com"]

  spec.summary = "Generates directories structure from a yml file"
  spec.description = "Generates directories from a yml file"
  spec.homepage = "https://github.com/harryuan65/DiretoryGenerator"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/harryuan65/DiretoryGenerator"
  spec.metadata["changelog_uri"] = "https://github.com/harryuan65/DiretoryGenerator/blob/master/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem

  # Uncomment to register a new dependency of your gem
  spec.add_runtime_dependency "thor", "~> 1.0"
  spec.add_runtime_dependency "erb", "~> 2.2.0"

  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "reek", "~> 6.1"
  spec.add_development_dependency "standard", "~> 1.3"
  spec.add_development_dependency "rubocop", "~> 1.29"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
