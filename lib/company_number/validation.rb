# frozen_string_literal: true

module CompanyNumber
  module Validation
    ISO_CODE_REGEXP = /^[A-Za-z]{2}$/.freeze

    AVAILABLE_METADATA_KEYS = %i[
      variations
      pattern
      country
      regexp
      name
    ].freeze

    class << self
      def check_object_class(object, expected_classes = [])
        return if expected_classes.include?(object.class)

        raise ArgumentError,
              "Expect #{object} class to be #{expected_classes.join(', ')}"
      end

      def check_object_inclusion(object, expected_objects = [])
        return if expected_objects.include?(object)

        raise ArgumentError,
              "Expect #{object} to be part of #{expected_objects}"
      end

      def check_string_format(string, regexp)
        return if string =~ regexp

        raise ArgumentError, "Expect #{string} to match regexp: #{regexp}"
      end

      def check_iso_code_format(country_code)
        return unless country_code

        check_object_class(country_code, [Symbol, String])
        check_string_format(country_code.to_s, ISO_CODE_REGEXP)
      end

      def check_country_code_metadata(metadata)
        metadata.each do |key, value|
          check_object_inclusion(key, AVAILABLE_METADATA_KEYS)
          object_class = key == :variations ? Array : String
          check_object_class(value, [object_class])
        end
      end

      def check_dictionary_structure(value)
        Validation.check_object_class(value, [Hash])

        value.each do |country_code, metadata|
          Validation.check_object_class(country_code, [Symbol])
          Validation.check_object_class(metadata, [Hash])
        end
      end
    end
  end
end
