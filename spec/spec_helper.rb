# frozen_string_literal: true

require "simplecov"

SimpleCov.start do
  coverage_dir "coverage-#{ENV['GITHUB_STEP_SUMMARY']}" if ENV["GITHUB_STEP_SUMMARY"]
end

require "company_number"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
