# frozen_string_literal: true

require "yaml"
require_relative "company_number/version"
require_relative "company_number/validation"

module CompanyNumber
  autoload :Configuration, "company_number/configuration"
  autoload :Dictionary,    "company_number/dictionary"
  autoload :Number,        "company_number/number"

  class << self
    def parse(company_number, country_code = nil)
      CompanyNumber::Number.new(company_number, country_code)
    end

    def configuration
      @_configuration ||= CompanyNumber::Configuration.new
    end

    def configure
      yield configuration
    end

    def dictionary
      configuration.dictionary.values
    end

    def excluded_countries
      configuration.excluded_countries
    end

    def custom_dictionary
      configuration.custom_dictionary
    end

    def strict_validation?
      configuration.strict_validation?
    end
  end
end
