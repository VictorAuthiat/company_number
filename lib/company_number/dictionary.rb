# frozen_string_literal: true

module CompanyNumber
  class Dictionary
    attr_reader :country_codes_metadata, :default_hash

    def self.default_dictionary_path
      File.join(File.dirname(__FILE__), "../../config/dictionary.json")
    end

    def initialize(country_codes_metadata = {})
      @country_codes_metadata = country_codes_metadata
      @default_hash           = load_default_hash

      validate_country_codes_metadata
    end

    def values
      @_values ||= fetch_values
    end

    private

    def fetch_values
      transformed_hash =
        @default_hash.merge(@country_codes_metadata) do |country_code, _, value|
          @default_hash[country_code.downcase].merge(value)
        end

      transformed_hash.reject do |country_code, _metadata|
        CompanyNumber.configuration.excluded_countries.include?(country_code)
      end
    end

    def load_default_hash
      JSON.parse(
        File.read(self.class.default_dictionary_path),
        symbolize_names: true
      )
    end

    def validate_country_codes_metadata
      Validation.check_object_class(@country_codes_metadata, [Hash])

      @country_codes_metadata.each do |country_code, metadata|
        Validation.check_string_format(country_code, /^[A-Za-z]{2}$/)
        Validation.check_country_code_metadata(metadata)
      end
    end
  end
end
