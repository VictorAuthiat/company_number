## Changelog

### 0.1.4 - 2022-12-11
  * Enhancements:
    * Change dictionary to JSON - 2ced0f8
    * Aggregating Failures - 54c5655

  * Deprecations:
    * Change `variations` class from *String* to *Array* - 0eb4074

### 0.1.3 - 2022-11-04
  * Enhancements:
    * Update CI - f67a9e3
    * Update RuboCop configuration - 3af3dc7

### 0.1.2 - 2022-04-21
  * Features:
    * Add custom configurations - aae0d51
      - custom_dictionary
      - strict_validation
      - excluded_countries

  * Enhancements:
    * Update RuboCop configuration - dcd9852

### 0.1.1 - 2022-04-04
  * Features:
    * Add dictionary to return the company number metadata - b19c8d9

  * Deprecations:
    * Remove `regexp` attr_reader (moved to metadata)
    * Remove `countries` attr_reader to use `CompanyNumber::Number#valid_countries`

  * Bug fixes:
    * Fix `CompanyNumber::Number#to_s` method not to return trailing whitespace when country code is not filled in - 9b4f3c53

  * Enhancements:
    * Update RuboCop configuration - e34eca5

### 0.1.0 - 2021-09-24

  * Initial release
