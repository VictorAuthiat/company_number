# frozen_string_literal: true

require_relative "lib/company_number/version"

Gem::Specification.new do |spec|
  spec.name     = "company_number"
  spec.version  = CompanyNumber::VERSION
  spec.authors  = ["victorauthiat"]
  spec.email    = ["authiatv@gmail.com"]

  spec.summary  = "Validate a company number according to a country code"
  spec.homepage = "https://github.com/victorauthiat/company_number"
  spec.license  = "MIT"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.2.25"
  spec.add_development_dependency "pry", "~> 0.14.1"
  spec.add_development_dependency "rake", "~> 13.0.6"
  spec.add_development_dependency "rspec", "~> 3.10.0"
  spec.add_development_dependency "simplecov", "~> 0.21.2"
end
