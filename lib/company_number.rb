# frozen_string_literal: true

require_relative "company_number/version"

if defined?(ActiveModel)
  require_relative "active_model/company_number_validator"
end

module CompanyNumber
  autoload :Number, 'company_number/number'

  VALIDATIONS = {
    at: /^([a-zA-Z]{2}\d{1,6}|\d{1,6})[A-Z]$/,
    be: /^\d{10}$/,
    bg: /^(\d{9}|\d{13})$/,
    hr: /^(\d{8}|\d{11})$/,
    cz: /^\d{8}$/,
    dk: /^\d{8}$/,
    ee: /^\d{8}$/,
    fi: /^\d{8}$/,
    fr: /^(\d{9}|\d{14})$/,
    de: /^[a-zA-Z]{1,3}\d{1,6}[a-zA-Z]{0,3}$/,
    gr: /^(\d{9}|\d{12})$/,
    hu: /^[a-zA-Z]{2}\d{10}$/,
    ie: /^(\d{5}|\d{6})$/,
    is: /^\d{10}$/,
    it: /^[a-zA-Z]{2}\d{7}|\d{11}$/,
    lv: /^\d{11}$/,
    li: /^[a-zA-Z]{3}\d{3}\s\d{3}\s\d{3}$/,
    lt: /^\d{9}$/,
    lu: /^[a-zA-Z]{1}\d{6}|[a-jA-J]\d{3}$/,
    mt: /^[a-zA-Z]{1}\d{5}$/,
    nl: /^\d{8}$/,
    no: /^(\d{9}|\d{11})$/,
    pl: /^(\d{6}|\d{8})$/,
    pt: /^(\d{9}|\d{3,6})$/,
    ro: /^\d{3}\s\d{2}\s\d{3}$/,
    sk: /^\d{3}\s\d{2}\s\d{3}$/,
    si: /^\d{10}|\d{7,10}$/,
    es: /^[a-zA-Z]{1}(\d{8}|\d{7}[a-zA-Z]{1})$/,
    se: /^\d{10}$/,
    ch: /^CHE\d{9}|\d{9}$/,
    gb: /^\d{8}|(OC|SC|NI)\d{6}|R\d{7}|IP\d{5}R$/
  }.freeze

  def self.parse(company_number, country_code = nil)
    CompanyNumber::Number.new(company_number, country_code)
  end
end
