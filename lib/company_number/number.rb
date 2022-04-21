# frozen_string_literal: true

module CompanyNumber
  class Number
    attr_reader :company_number, :country_code, :metadata

    def initialize(company_number, country_code = nil)
      Validation.check_object_class(company_number, [String])
      Validation.check_object_class(country_code, [NilClass, Symbol, String])
      Validation.check_iso_code_format(country_code)

      @company_number = company_number
      @country_code   = country_code&.downcase&.to_sym
      @metadata       = CompanyNumber.dictionary[@country_code] || {}
    end

    def to_h
      {
        company_number: @company_number,
        country_code: @country_code,
        metadata: @metadata
      }
    end

    def to_s
      "#{@company_number} #{@country_code}".strip
    end

    def ==(other)
      self.class == other.class && other.to_s == to_s
    end

    def valid?
      if CompanyNumber.strict_validation?
        country_code_present_and_valid_country?
      else
        no_country_code_or_valid_country?
      end
    end

    def valid_country?
      CompanyNumber.dictionary.keys.include?(@country_code) ||
        (!CompanyNumber.strict_validation? && !!@country_code)
    end

    def valid_for_country?(country_code)
      Validation.check_iso_code_format(country_code)
      regexp = CompanyNumber.dictionary.dig(country_code, :regexp)
      (!CompanyNumber.strict_validation? && !regexp) || valid_code?(regexp)
    end

    def valid_countries
      return [] if !valid_country? && @country_code

      CompanyNumber
        .dictionary
        .keys
        .select { |country_code| valid_for_country?(country_code) }
    end

    private

    def no_country_code_or_valid_country?
      !@country_code || valid_for_country?(@country_code)
    end

    def country_code_present_and_valid_country?
      !!@country_code && valid_for_country?(@country_code)
    end

    def valid_code?(regexp = nil)
      !!regexp && !!(@company_number =~ Regexp.new(regexp))
    end
  end
end
