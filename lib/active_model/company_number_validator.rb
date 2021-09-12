class CompanyNumberValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if CompanyNumber.parse(value, country_code(record)).valid?

    record.errors.add(attribute, options[:message] || :invalid)
  end

  private

  def country_code(record)
    case options[:with]
    when Symbol
      options[:with]
    when Proc
      options[:with].call(record)
    else
      raise ArgumentError, 'invalid option'
    end
  end
end
