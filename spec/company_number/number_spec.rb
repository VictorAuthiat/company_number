require 'spec_helper'

RSpec.describe CompanyNumber::Number do
  let(:number) do
    described_class.new(company_number, country_code)
  end

  describe '#initialize' do
    subject { described_class.new(company_number, country_code) }

    context 'given the company_number is not String' do
      let(:company_number) { :foo }
      let(:country_code) { nil }

      it 'raise error ArgumentError' do
        expect { subject }.to raise_error(ArgumentError)
      end
    end

    context 'given the company_number is String' do
      let(:company_number) { 'foo' }

      context 'given the country_code is not String, Symbol, or nil' do
        let(:country_code) { [] }

        it 'raise error ArgumentError' do
          expect { subject }.to raise_error(ArgumentError)
        end
      end

      ['at', :be, nil].each do |country_code|
        context "given the country_code is #{country_code.class}" do
          let(:country_code) { country_code }

          it 'does not raise error' do
            expect { subject }.not_to raise_error
          end
        end
      end
    end
  end

  context 'given valid attributes' do
    let(:company_number) { 'foo' }
    let(:country_code) { nil }

    describe '#valid?' do
      subject { number.valid? }

      context 'given the country_code is nil' do
        it { expect(subject).to eq(true) }
      end

      context 'given the country_code is not supported' do
        let(:country_code) { :aa }

        context 'given the configuration rejects unknown countries' do
          before do
            CompanyNumber.configuration.strict_validation = true
          end

          it { is_expected.to eq(false) }
        end

        context 'given the configuration does not reject unknown countries' do
          before do
            CompanyNumber.configuration.strict_validation = false
          end

          it { is_expected.to eq(true) }
        end
      end

      context 'given the country_code is supported' do
        let(:country_code) { :fr }

        context 'given the company_number match regexp pattern' do
          let(:company_number) { '123456789' }

          it { is_expected.to eq(true) }
        end

        context 'given the company_number does not match regexp pattern' do
          let(:company_number) { '123' }

          it { is_expected.to eq(false) }
        end
      end
    end

    describe '#valid_country?' do
      subject { number.valid_country? }

      context 'given the country_code is nil' do
        let(:country_code) { nil }

        it { is_expected.to eq(false) }
      end

      context 'given the country_code is not supported' do
        let(:country_code) { :aa }

        context 'given the configuration rejects unknown countries' do
          before do
            CompanyNumber.configuration.strict_validation = true
          end

          it { is_expected.to eq(false) }
        end

        context 'given the configuration does not reject unknown countries' do
          before do
            CompanyNumber.configuration.strict_validation = false
          end

          it { is_expected.to eq(true) }
        end
      end

      context 'given the country_code is supported' do
        let(:country_code) { :fr }

        it { is_expected.to eq(true) }
      end
    end

    describe '#valid_for_country?' do
      subject { number.valid_for_country?(country) }

      context 'given an invalid country code type' do
        let(:country) { 'foo' }

        it 'raise error ArgumentError' do
          expect { subject }.to raise_error(ArgumentError)
        end
      end

      context 'given a valid country code type' do
        let(:country) { :foo }

        context 'given an invalid country code format' do
          it 'raise error ArgumentError' do
            expect { subject }.to raise_error(ArgumentError)
          end
        end

        context 'given an valid country code format' do
          context 'given the country_code is not supported' do
            let(:country) { :tt }

            context 'given the configuration rejects unknown countries' do
              before do
                CompanyNumber.configuration.strict_validation = true
              end

              it { is_expected.to eq(false) }
            end

            context 'given the configuration does not reject unknown countries' do
              before do
                CompanyNumber.configuration.strict_validation = false
              end

              it { is_expected.to eq(true) }
            end
          end

          context 'given the specified country is supported' do
            let(:country) { :fr }

            context 'given the company_number does not match regexp' do
              let(:company_number) { 'foo' }

              it { is_expected.to eq(false) }
            end

            context 'given the company_number match regexp' do
              let(:company_number) { '123456789' }

              it { is_expected.to eq(true) }
            end
          end
        end
      end
    end

    describe '#to_s' do
      subject { number.to_s }
      let(:company_number) { '123456789' }

      context "given a country code" do
        let(:country_code) { :fr }

        it { is_expected.to be_a(String) }

        it "returns the company number with the country code" do
          expect(subject).to eq("#{company_number} #{country_code}")
        end
      end

      context "given no country code" do
        let(:country_code) { nil }

        it { is_expected.to be_a(String) }

        it "returns only the company number" do
          expect(subject).to eq(company_number)
        end
      end
    end

    describe '#to_h' do
      subject { number.to_h }

      let(:company_number) { '123456789' }
      let(:country_code) { :fr }

      let(:expected) do
        {
          company_number: company_number,
          country_code: country_code,
          metadata: number.metadata
        }
      end

      it { is_expected.to be_a(Hash) }

      it 'returns attributes with metadata' do
        expect(subject).to eq(expected)
      end
    end

    describe '#==' do
      subject { number == other_company_number }
      let(:company_number) { 'foo' }
      let(:country_code) { :fr }

      context 'given the same attributes' do
        let(:other_company_number) do
          described_class.new(company_number, country_code)
        end

        it { is_expected.to eq(true) }
      end

      context 'given a different company_number' do
        let(:other_company_number) do
          described_class.new('bar', country_code)
        end

        it { is_expected.to eq(false) }
      end

      context 'given a different country_code' do
        let(:other_company_number) do
          described_class.new(company_number, :be)
        end

        it { is_expected.to eq(false) }
      end
    end

    describe '#valid_countries' do
      subject { number.valid_countries }

      let(:company_number) { '123456789' }

      context "given an unavailable country code" do
        let(:country_code) { :aa }

        context 'given the configuration rejects unknown countries' do
          before do
            CompanyNumber.configuration.strict_validation = true
          end

          it "returns an empty array" do
            expect(subject).to eq([])
          end
        end

        context 'given the configuration does not reject unknown countries' do
          before do
            CompanyNumber.configuration.strict_validation = false
          end

          it "returns countries that match" do
            expect(subject).to eq(%i[bg fr gr lt no pt si ch gb])
          end
        end
      end

      context "given no country code" do
        let(:country_code) { nil }

        it "returns countries that match" do
          expect(subject).to eq(%i[bg fr gr lt no pt si ch gb])
        end
      end
    end
  end
end
