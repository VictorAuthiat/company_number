# CompanyNumber

[![Build Status](https://github.com/victorauthiat/company_number/actions/workflows/build.yml/badge.svg)](https://github.com/victorauthiat/company_number/actions/workflows/build.yml)

CompanyNumber is a gem allowing you to validate company number based on a country code

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'company_number'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install company_number

## Usage

You can obtain a `CompanyNumber::Number` object calling `parse` method:

```ruby
company_number = CompanyNumber.parse('123456789', :fr)

# => #<CompanyNumber::Number:0x00007fc015d04e18 @company_number="123456789", @country_code=:fr, @metadata={:country=>"France", :name=>"Numéro SIREN ou SIRET", :regexp=>"^(\\d{9}|\\d{14})$", :pattern=>"9 numbers (XXXXXXXXX) or 14 numbers (XXXXXXXXXXXXXX)"}>
```

Then you can run validation methods

```ruby
company_number.valid?
# => true
company_number.valid_country?
# => true
company_number.valid_for_country?(:at)
# => false
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
CompanyNumber.parse('123') == CompanyNumber.parse('123')
# => true
```

Finally you can get the whole dictionary
```ruby
CompanyNumber.dictionary
# => {:at=>{:country=>"Austria", :name=>"Firmenbuchnummer", :regexp=>"^([a-zA-Z]{2}\\d{1,6}|\\d{1,6})[A-Z]$", :pattern=>"2 letters + 6 numbers + 1 letter (LLXXXXXXL)", :variations=>"1-6 numbers + 1 letter (XXXXXXL)"}, ...}
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/victorauthiat/company_number. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/victorauthiat/company_number/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the CompanyNumber project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/victorauthiat/company_number/blob/master/CODE_OF_CONDUCT.md).
