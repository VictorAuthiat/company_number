require 'spec_helper'

RSpec.describe CompanyNumberValidator do
  subject { company_klass.new }

  before(:each) do
    subject.company_number = company_number
    subject.country_code = country_code
  end

  let(:company_number) { 'test' }
  let(:country_code) { 'FR' }

  context 'given Proc' do
    let(:company_klass) do
      Class.new do
        include ActiveModel::Validations
        attr_accessor :company_number, :country_code

        validates :company_number,
                  company_number: proc { |record| record.country_code }
      end
    end

    context 'given invalid company_number' do
      it 'does not raise error' do
        expect { subject.valid? }.not_to raise_error
      end

      it { is_expected.not_to be_valid }
    end

    context 'given invalid company_number' do
      let(:company_number) { '123456789' }
      let(:country_code) { 'FR' }

      it 'does not raise error' do
        expect { subject.valid? }.not_to raise_error
      end

      it { is_expected.to be_valid }
    end
  end

  context 'given Symbol' do
    let(:company_klass) do
      Class.new do
        include ActiveModel::Validations
        attr_accessor :company_number, :country_code

        validates :company_number, company_number: :fr
      end
    end

    it 'does not raise error' do
      expect { subject.valid? }.not_to raise_error
    end

    context 'given invalid company_number' do
      it { is_expected.not_to be_valid }
    end

    context 'given invalid company_number' do
      let(:company_number) { '123456789' }
      let(:country_code) { 'FR' }

      it { is_expected.to be_valid }
    end
  end

  context 'given invalid option' do
    let(:company_klass) do
      Class.new do
        include ActiveModel::Validations
        attr_accessor :company_number, :country_code

        validates :company_number, company_number: 'fr'
      end
    end

    it 'does not raise error' do
      expect { subject.valid? }.to raise_error(ArgumentError)
    end
  end
end
