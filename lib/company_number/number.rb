module CompanyNumber
  class Number
    attr_reader :company_number, :country_code, :metadata

    def initialize(company_number, country_code = nil)
      check_param_type(company_number, [String])
      check_param_type(country_code, [NilClass, Symbol, String])

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
      !valid_country? || valid_for_country?(@country_code)
    end

    def valid_country?
      CompanyNumber.dictionary.keys.include?(@country_code)
    end

    def valid_for_country?(country_code)
      check_param_type(country_code, [Symbol])

      !!(@company_number =~ country_code_regexp(country_code))
    end

    def valid_countries
      return [] if !valid_country? && @country_code

      CompanyNumber
        .dictionary
        .keys
        .select { |country_code| valid_for_country?(country_code) }
    end

    private

    def country_code_regexp(country_code)
      regexp = CompanyNumber.dictionary.dig(country_code, :regexp)

      Regexp.new(regexp) unless regexp.nil?
    end

    def check_param_type(param, expected_classes = [])
      return if expected_classes.include?(param.class)

      raise ArgumentError,
            "Expect class of #{param} to be #{expected_classes.join(', ')}"
    end
  end
end
