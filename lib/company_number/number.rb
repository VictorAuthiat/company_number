module CompanyNumber
  class Number
    attr_reader :company_number, :country_code, :countries, :regexp

    def initialize(company_number, country_code = nil)
      @company_number = company_number
      @country_code = country_code

      validate_attributes
      fetch_countries
      fetch_regexp
    end

    def valid?
      !valid_country? || valid_for_country?(@country_code)
    end

    def valid_country?
      CompanyNumber::VALIDATIONS.keys.include?(@country_code)
    end

    def valid_for_country?(country_code)
      !!(@company_number =~ fetch_regexp(country_code))
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
      other.is_a?(CompanyNumber::Number) && other.to_s == to_s
    end

    private

    def validate_attributes
      if @country_code.is_a?(String)
        @country_code = @country_code.downcase.to_sym
      end

      unless @company_number.is_a?(String)
        raise ArgumentError, 'Expect company_number to be String'
      end

      unless [NilClass, Symbol].include?(@country_code.class)
        raise ArgumentError, 'Expect country_code to be Symbol or nil'
      end
    end

    def fetch_countries
      @countries =
        if valid_country? || @country_code.nil?
          CompanyNumber::VALIDATIONS.select do |_country_code, regexp|
            @company_number =~ regexp
          end.keys
        else
          []
        end
    end

    def fetch_regexp(country_code = nil)
      @regexp = CompanyNumber::VALIDATIONS[country_code || @country_code]
    end
  end
end
