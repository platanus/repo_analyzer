$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem"s version:
require "repo_analyzer/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name          = "repo_analyzer"
  s.version       = RepoAnalyzer::VERSION
  s.authors       = ["Platanus", "Leandro Segovia"]
  s.email         = ["rubygems@platan.us", "leandro@platan.us"]
  s.homepage      = "https://github.com/platanus/repo_analyzer"
  s.summary       = "Tool to extract technical debt"
  s.description   = "Rails engine to extract technical debt"
  s.license       = "MIT"

  s.files = `git ls-files`.split($/).reject { |fn| fn.start_with? "spec" }
  s.bindir = "exe"
  s.executables = s.files.grep(%r{^exe/}) { |f| File.basename(f) }
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "bundler-audit"
  s.add_dependency "brakeman"
  s.add_dependency "fasterer"
  s.add_dependency "octokit", "~> 4.0"
  s.add_dependency "rails", ">= 6.0"
  s.add_dependency "rails_best_practices"
  s.add_dependency "reek"
  s.add_dependency "rubocop", "~> 1.9"
  s.add_dependency "rubocop-performance"
  s.add_dependency "rubocop-platanus", "~> 0.2"
  s.add_dependency "rubocop-rails"
  s.add_dependency "rubocop-rspec", "~> 2.2"

  s.add_development_dependency "bundler", "~> 2.4.3"
  s.add_development_dependency "coveralls"
  s.add_development_dependency "factory_bot_rails"
  s.add_development_dependency "guard-rspec"
  s.add_development_dependency "pry"
  s.add_development_dependency "pry-rails"
  s.add_development_dependency "rspec_junit_formatter"
  s.add_development_dependency "rspec-rails"
end
