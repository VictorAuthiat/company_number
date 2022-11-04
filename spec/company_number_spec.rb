# frozen_string_literal: true

RSpec.describe CompanyNumber do
  it "has a version number" do
    expect(CompanyNumber::VERSION).not_to eq(nil)
  end

  describe ".parse" do
    subject { CompanyNumber.parse("123456789", :fr) }

    it "returns a CompanyNumber::Number object" do
      expect(subject).to be_a(CompanyNumber::Number)
    end
  end

  describe ".configuration" do
    subject { described_class.configuration }

    it "returns CompanyNumber::Configuration" do
      expect(subject).to be_a(CompanyNumber::Configuration)
    end
  end

  describe ".configure" do
    it { expect { |b| described_class.configure(&b) }.to yield_with_args }
  end

  describe ".dictionary" do
    subject { described_class.dictionary }

    it "returns Hash" do
      expect(subject).to be_a(Hash)
    end

    it "fetch dictionary from configuration" do
      expect(CompanyNumber.configuration)
        .to receive(:dictionary).and_call_original

      subject
    end
  end

  describe ".excluded_countries" do
    subject { described_class.excluded_countries }

    it "returns Array" do
      expect(subject).to be_a(Array)
    end

    it "fetch excluded countries from configuration" do
      expect(CompanyNumber.configuration)
        .to receive(:excluded_countries).and_call_original

      subject
    end
  end

  describe ".custom_dictionary" do
    subject { described_class.custom_dictionary }

    it "returns Hash" do
      expect(subject).to be_a(Hash)
    end

    it "fetch custom dictionary from configuration" do
      expect(CompanyNumber.configuration)
        .to receive(:custom_dictionary).and_call_original

      subject
    end
  end

  describe ".strict_validation?" do
    subject { described_class.strict_validation? }

    it "returns Boolean" do
      expect(subject).to be_a(FalseClass)
    end

    it "fetch strict validation from configuration" do
      expect(CompanyNumber.configuration)
        .to receive(:strict_validation?).and_call_original

      subject
    end
  end
end
