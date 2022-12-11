# CompanyNumber

[![Gem Version](https://badge.fury.io/rb/company_number.svg)](https://badge.fury.io/rb/company_number)
[![Build Status](https://github.com/VictorAuthiat/company_number/actions/workflows/ci.yml/badge.svg)](https://github.com/VictorAuthiat/company_number/actions/workflows/ci.yml)
[![Code Climate](https://codeclimate.com/github/VictorAuthiat/company_number/badges/gpa.svg)](https://codeclimate.com/github/VictorAuthiat/company_number)
[![Test Coverage](https://codeclimate.com/github/VictorAuthiat/company_number/badges/coverage.svg)](https://codeclimate.com/github/VictorAuthiat/company_number/coverage)
[![Issue Count](https://codeclimate.com/github/VictorAuthiat/company_number/badges/issue_count.svg)](https://codeclimate.com/github/VictorAuthiat/company_number)

CompanyNumber is a gem allowing you to validate company number based on a country code

## Installation

Add this line to your application"s Gemfile:

```ruby
gem "company_number"
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install company_number

## Usage

You can obtain a `CompanyNumber::Number` object calling `parse` method:

```ruby
company_number = CompanyNumber.parse("123456789", :fr)

# => #<CompanyNumber::Number:0x00007fc015d04e18 @company_number="123456789", @country_code=:fr, @metadata={:country=>"France", :name=>"Numéro SIREN ou SIRET", :regexp=>"^(\\d{9}|\\d{14})$", :pattern=>"9 numbers (XXXXXXXXX) or 14 numbers (XXXXXXXXXXXXXX)"}>
```

Then you can run validation methods

```ruby
company_number.valid?                  # => true
company_number.valid_country?          # => true
company_number.valid_for_country?(:at) # => false
```

You can also fetch valid countries

```ruby
company_number.valid_countries
# => [:bg, :fr, :gr, :lt, :no, :pt, :si, :ch, :gb]
```

Additionally you can get metadata

```ruby
company_number.metadata
# => {:country=>"France", :name=>"Numéro SIREN ou SIRET", :regexp=>"^(\\d{9}|\\d{14})$", :pattern=>"9 numbers (XXXXXXXXX) or 14 numbers (XXXXXXXXXXXXXX)"}
```

There is a `to_s` method, which returns the company number with the country code.

```ruby
company_number.to_s
# => "123456789 fr"
```

There is a `to_h` method, which returns all attr_reader

```ruby
company_number.to_h
# => {:company_number=>"123456789", :country_code=>:fr, :metadata=>{:country=>"France", :name=>"Numéro SIREN ou SIRET", :regexp=>"^(\\d{9}|\\d{14})$", :pattern=>"9 numbers (XXXXXXXXX) or 14 numbers (XXXXXXXXXXXXXX)"}}
```

You can compare 2 instances of `CompanyNumber::Number` with `==` method

```ruby
CompanyNumber.parse("123") == CompanyNumber.parse("123")
# => true
```

Finally you can get the whole dictionary
```ruby
CompanyNumber.dictionary
# => {:at=>{:country=>"Austria", :name=>"Firmenbuchnummer", :regexp=>"^([a-zA-Z]{2}\\d{1,6}|\\d{1,6})[A-Z]$", :pattern=>"2 letters + 6 numbers + 1 letter (LLXXXXXXL)", :variations=>["1-6 numbers + 1 letter (XXXXXXL)"]}, ...}
```

## Configuration
You can configure your own dictionary using **custom_dictionary**.
It should be a hash with the country codes as keys and the associated metadata as values.

Available metadata keys:
- country - *String*
- name - *String*
- regexp - *String*
- pattern - *String*
- variations - *Array*

**Example:**
```ruby
CompanyNumber.parse("123456789", :fr).valid?      # => true
CompanyNumber.parse("12345678901234", :fr).valid? # => true

CompanyNumber.configure do |config|
  config.custom_dictionary = { fr: { regexp: "^\d{14}$" } }
end

CompanyNumber.parse("123456789", :fr).valid?      # => false
CompanyNumber.parse("12345678901234", :fr).valid? # => true
```

**strict_validation:**

You can also enable strict validation to reject unknow countries:

```ruby
CompanyNumber.parse("123456789").valid?      # => true
CompanyNumber.parse("123456789", :tt).valid? # => true

CompanyNumber.configure do |config|
  config.strict_validation = true
end

CompanyNumber.parse("123456789").valid?      # => false
CompanyNumber.parse("123456789", :tt).valid? # => false
```

**excluded_countries:**

You may want to exclude some countries, this allows you to automatically validate the country"s company number when strict validation is not enabled. You can also exclude a country to overwrite all its metadata and define it later in a custom dictionary.

**Example:**
```ruby
CompanyNumber.parse("123456789", :be).valid? # => false

CompanyNumber.configure do |config|
  config.excluded_countries = [:be]
end

CompanyNumber.parse("123456789", :be).valid? # => true
```

## Default dictionary:

- `:at` - **Austria** - Firmenbuchnummer
- `:be` - **Belgium** - Numéro d"entreprise Vestigingseenheidsnummer
- `:bg` - **Bulgaria** - ЕИК (EIK)/ПИК (PIK) (UIC/PIC)
- `:hr` - **Croatia** - Matični broj poslovnog subjekta (MBS)
- `:cy` - **Cyprus** - Αριθμός Μητρώου Εταιρίας Şirket kayıt numarası
- `:cz` - **Czech** - epublic (Identifikační číslo
- `:dk` - **Denmark** - CVR-nummer
- `:ee` - **Estonia** - Kood
- `:fi` - **Finland** - Y-tunnus FO-nummer
- `:fr` - **France** - Numéro SIREN ou SIRET
- `:de` - **Germany** - Nummer der Firma Registernummer
- `:gr` - **Greece** - Αριθμό Φορολογικού Μητρώου (Α.Φ.Μ.)
- `:hu` - **Hungary** - Cégjegyzékszáma
- `:ie` - **Ireland** - Company Number
- `:is` - **Island** - TIN
- `:it` - **Italy** - Codice fiscale
- `:lv` - **Latvia** - Reģistrācijas numurs
- `:li` - **Liechtenstein** - UID
- `:lt` - **Lithuania** - Juridinio asmens kodas
- `:lu` - **Luxembourg** - Numéro d"immatriculation
- `:mt` - **Malta** - Registration Number
- `:nl` - **Netherlands** - KvK-nummer
- `:no` - **Norway** - TIN
- `:pl` - **Poland** - Numer w Krajowym Rejestrze Sądowym (numer KRS)) NIPC)
- `:ro` - **Romania** - Număr de ordine în Registrul Comerţului
- `:sk` - **Slovakia** - Identifikačného čísla Identification number
- `:si` - **Slovenia** - Matična številka
- `:es` - **Spain** - Número de identificación fiscal (NIF)
- `:se` - **Sweden** - Registreringsnummer
- `:ch` - **Switzerland** - UID
- `:gb` - **United Kingdom** - Company Number Registration Number

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/victorauthiat/company_number. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/victorauthiat/company_number/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the CompanyNumber project"s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/victorauthiat/company_number/blob/master/CODE_OF_CONDUCT.md).
