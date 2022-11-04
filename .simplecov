# frozen_string_literal: true

require "simplecov_json_formatter"

SimpleCov.start do
  coverage_dir "coverage"
  add_filter "spec"
end

SimpleCov.formatters = SimpleCov::Formatter::JSONFormatter
