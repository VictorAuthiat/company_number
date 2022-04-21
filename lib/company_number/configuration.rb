# frozen_string_literal: true

module CompanyNumber
  class Configuration
    attr_reader :excluded_countries,
                :custom_dictionary,
                :strict_validation

    def initialize
      @excluded_countries = []
      @custom_dictionary  = {}
      @strict_validation  = nil
    end

    def dictionary
      @dictionary ||= CompanyNumber::Dictionary.new(@custom_dictionary)
    end

    def strict_validation?
      !!@strict_validation
    end

    def custom_dictionary=(value)
      Validation.check_dictionary_structure(value)

      @dictionary        = nil
      @custom_dictionary = value
    end

    def excluded_countries=(value)
      Validation.check_object_class(value, [Array])

      @dictionary         = nil
      @excluded_countries = value
    end

    def strict_validation=(value)
      Validation.check_object_class(value, [TrueClass, FalseClass, NilClass])

      @strict_validation = value
    end
  end
end
