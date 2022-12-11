require "spec_helper"

RSpec.describe CompanyNumber::Dictionary do
  describe "#initialize" do
    it "detects invalid country_codes_metadata" do
      expect { described_class.new(:foo) }.to raise_error(ArgumentError)
      expect { described_class.new({ foo: :bar }) }.to raise_error(ArgumentError)
      expect { described_class.new({ foo: { bar: :baz } }) }.to raise_error(ArgumentError)
      expect { described_class.new({ fr: { bar: :baz } }) }.to raise_error(ArgumentError)
      expect { described_class.new({ fr: { name: :foo } }) }.to raise_error(ArgumentError)
      expect { described_class.new({ fr: { variations: "foo" } }) }.to raise_error(ArgumentError)
      expect { described_class.new({ fr: { variations: ["foo"] } }) }.not_to raise_error
      expect { described_class.new({ fr: { name: "foo" } }) }.not_to raise_error
      expect { described_class.new({ fr: { regexp: "foo" } }) }.not_to raise_error
      expect { described_class.new({ fr: { country: "foo" } }) }.not_to raise_error
      expect { described_class.new({ fr: { pattern: "foo" } }) }.not_to raise_error
      expect { described_class.new({}) }.not_to raise_error
    end
  end

  describe "#values" do
    subject { dictionary.values }

    let(:dictionary)      { described_class.new(dictionary_hash) }
    let(:dictionary_hash) { { fr: { regexp: "foo" } } }

    context "given @_values instance variable is nil" do
      before { dictionary.instance_variable_set("@_values", nil) }

      it "fetch values" do
        expect(dictionary).to(
          receive(:fetch_values)
          .exactly(1)
          .times
          .and_call_original
        )

        subject
      end

      it "returns Hash" do
        expect(subject).to be_a(Hash)
      end
    end

    context "given @_values instance variable exists" do
      before { dictionary.instance_variable_set("@_values", dictionary_hash) }

      it "does not fetch values" do
        expect(dictionary).not_to receive(:fetch_values)

        subject
      end

      it "returns Hash" do
        expect(subject).to be_a(Hash)
      end
    end
  end
end
