require 'spec_helper'

RSpec.describe CompanyNumber::Configuration do
  let(:configuration) { described_class.new }

  describe '#dictionary' do
    subject { configuration.dictionary }

    it { is_expected.to be_a(CompanyNumber::Dictionary) }
  end

  describe '#strict_validation?' do
    subject { configuration.strict_validation? }

    context 'given strict_validation attribute is nil' do
      before { configuration.strict_validation = nil }

      it { is_expected.to eq(false) }
    end

    context 'given strict_validation attribute is true' do
      before { configuration.strict_validation = true }

      it { is_expected.to eq(true) }
    end

    context 'given strict_validation attribute is false' do
      before { configuration.strict_validation = false }

      it { is_expected.to eq(false) }
    end
  end

  describe '#custom_dictionary=' do
    subject { configuration.custom_dictionary = custom_dictionary }

    let(:custom_dictionary)   { { fr: {} } }
    let(:original_dictionary) { { en: {} } }

    it 'validates object class' do
      expect(CompanyNumber::Validation).to(
        receive(:check_dictionary_structure)
        .with(custom_dictionary)
        .exactly(1)
        .times
        .and_call_original
      )

      subject
    end

    context 'given an invalid object' do
      let(:custom_dictionary) { :foo }

      it 'raise ArgumentError' do
        expect { subject }.to raise_error(ArgumentError)
      end
    end

    context 'given valid object' do
      let(:custom_dictionary) { { fr: {} } }

      it 'does not raise error' do
        expect { subject }.not_to raise_error
      end

      context 'given dictionary exist' do
        before do
          configuration.instance_variable_set(
            '@dictionary',
            original_dictionary
          )
        end

        it 'resets dictionary' do
          expect(configuration.instance_variable_get('@dictionary'))
            .to eq(original_dictionary)

          subject

          expect(configuration.instance_variable_get('@dictionary'))
            .to eq(nil)
        end
      end

      it 'set custom_dictionary instance variable' do
        expect { subject }.to(
          change(
            configuration,
            :custom_dictionary
          ).from({}).to(custom_dictionary)
        )
      end
    end
  end

  describe '#excluded_countries=' do
    subject { configuration.excluded_countries = excluded_countries }

    let(:excluded_countries)  { [] }
    let(:custom_dictionary)   { { fr: {} } }
    let(:original_dictionary) { { en: {} } }

    it 'validates object class' do
      expect(CompanyNumber::Validation).to(
        receive(:check_object_class)
        .with(excluded_countries, [Array])
        .exactly(1)
        .times
        .and_call_original
      )

      subject
    end

    context 'given an invalid object' do
      let(:excluded_countries) { :foo }

      it 'raise ArgumentError' do
        expect { subject }.to raise_error(ArgumentError)
      end
    end

    context 'given valid object' do
      let(:excluded_countries) { [:fr] }

      it 'does not raise error' do
        expect { subject }.not_to raise_error
      end

      context 'given dictionary exist' do
        before do
          configuration.instance_variable_set(
            '@dictionary',
            original_dictionary
          )
        end

        it 'resets dictionary' do
          expect(configuration.instance_variable_get('@dictionary'))
            .to eq(original_dictionary)

          subject

          expect(configuration.instance_variable_get('@dictionary'))
            .to eq(nil)
        end
      end

      it 'set excluded_countries instance variable' do
        expect { subject }.to(
          change(
            configuration,
            :excluded_countries
          ).from([]).to(excluded_countries)
        )
      end
    end
  end

  describe '#strict_validation=' do
    subject { configuration.strict_validation = strict_validation }

    let(:strict_validation) { nil }

    it 'validates object class' do
      expect(CompanyNumber::Validation).to(
        receive(:check_object_class)
        .with(strict_validation, [TrueClass, FalseClass, NilClass])
        .exactly(1)
        .times
        .and_call_original
      )

      subject
    end

    context 'given an invalid object' do
      let(:strict_validation) { :foo }

      it 'raise ArgumentError' do
        expect { subject }.to raise_error(ArgumentError)
      end
    end

    context 'given valid object' do
      let(:strict_validation) { true }

      it 'does not raise error' do
        expect { subject }.not_to raise_error
      end

      it 'set strict_validation instance variable' do
        expect { subject }.to(
          change(
            configuration,
            :strict_validation
          ).from(nil).to(strict_validation)
        )
      end
    end
  end
end
