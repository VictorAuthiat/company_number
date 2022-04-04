# frozen_string_literal: true

require "yaml"
require_relative "company_number/version"

module CompanyNumber
  autoload :Number, 'company_number/number'

  class << self
    def parse(company_number, country_code = nil)
      CompanyNumber::Number.new(company_number, country_code)
    end

    def dictionary
      @_dictionary ||= YAML.safe_load(
        File.read(File.join(File.dirname(__FILE__), '../config/dictionary.yml')),
        symbolize_names: true
      )
    end
  end
end
