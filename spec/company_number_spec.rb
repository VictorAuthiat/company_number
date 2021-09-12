# frozen_string_literal: true

RSpec.describe CompanyNumber do
  it 'has a version number' do
    expect(CompanyNumber::VERSION).not_to eq(nil)
  end

  describe '.parse' do
    subject { CompanyNumber.parse('123456789', :fr) }

    it 'returns a CompanyNumber::Number object' do
      expect(subject).to be_a(CompanyNumber::Number)
    end
  end
end
