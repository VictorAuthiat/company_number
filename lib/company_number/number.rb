module CompanyNumber
  class Number
    attr_reader :company_number, :country_code, :countries, :regexp

    def initialize(company_number, country_code = nil)
      validate_attributes(company_number, country_code)

      @company_number = company_number
      @country_code = country_code&.downcase&.to_sym
      @countries = fetch_countries
      @regexp = CompanyNumber::VALIDATIONS[@country_code]
    end

    def valid?
      !valid_country? || valid_for_country?(@country_code)
    end

    def valid_country?
      CompanyNumber::VALIDATIONS.keys.include?(@country_code)
    end

    def valid_for_country?(country_code)
      !!(@company_number =~ CompanyNumber::VALIDATIONS[country_code])
    end

    def to_s
      "#{@company_number} #{@country_code}"
    end

    def to_h
      {
        company_number: @company_number,
        country_code: @country_code,
        countries: @countries,
        regexp: @regexp
      }
    end

    def ==(other)
      self.class == other.class && other.to_s == to_s
    end

    private

    def validate_attributes(company_number, country_code)
      unless company_number.is_a?(String)
        raise ArgumentError, 'Expect company_number to be String'
      end

      return if [NilClass, Symbol, String].include?(country_code.class)

      raise ArgumentError, 'Expect country_code to be String, Symbol or nil'
    end

    def fetch_countries
      return [] if !valid_country? && @country_code

      CompanyNumber::VALIDATIONS.select do |country_code, regexp|
        country_code if @company_number =~ regexp
      end.keys
    end
  end
end
