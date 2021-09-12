# frozen_string_literal: true

require_relative "company_number/version"

if defined?(ActiveModel)
  require_relative "active_model/company_number_validator"
end

module CompanyNumber
  autoload :Number, 'company_number/number'

  VALIDATIONS = { fr: /^(\d{9}|\d{14})$/ }.freeze

  def self.parse(company_number, country_code = nil)
    CompanyNumber::Number.new(company_number, country_code)
  end
end
