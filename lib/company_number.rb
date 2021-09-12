# frozen_string_literal: true

require_relative "company_number/version"

module CompanyNumber
  autoload :Number, 'company_number/number'

  VALIDATIONS = { fr: /^(\d{9}|\d{14})$/ }.freeze

  def self.parse(company_number, country_code = nil)
    CompanyNumber::Number.new(company_number, country_code)
  end
end
