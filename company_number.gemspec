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
  spec.required_ruby_version = ">= 2.5"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "simplecov"
end
