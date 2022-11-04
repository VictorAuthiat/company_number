require "spec_helper"

RSpec.describe CompanyNumber::Validation do
  describe ".check_object_class" do
    it "detects invalid arguments" do
      expect { described_class.check_object_class(1, [String]) }.to raise_error(ArgumentError)
      expect { described_class.check_object_class(1, [Integer]) }.not_to raise_error
      expect { described_class.check_object_class(:foo, [String]) }.to raise_error(ArgumentError)
      expect { described_class.check_object_class(:foo, [Symbol]) }.not_to raise_error
      expect { described_class.check_object_class("bar", [Symbol]) }.to raise_error(ArgumentError)
      expect { described_class.check_object_class("bar", [String]) }.not_to raise_error
    end
  end

  describe ".check_object_inclusion" do
    it "detects invalid arguments" do
      expect { described_class.check_object_inclusion(1, [2, 3, 4]) }.to raise_error(ArgumentError)
      expect { described_class.check_object_inclusion(1, [1, 2, 3]) }.not_to raise_error
      expect { described_class.check_object_inclusion(Integer, [String, Hash]) }.to raise_error(ArgumentError)
      expect { described_class.check_object_inclusion(Symbol, [Symbol, Hash]) }.not_to raise_error
    end
  end

  describe ".check_string_format" do
    it "validates given string" do
      expect { described_class.check_string_format("foo", /bar/) }.to raise_error(ArgumentError)
      expect { described_class.check_string_format("foo", /foo/) }.not_to raise_error
    end
  end

  describe ".check_iso_code_format" do
    subject { described_class.check_iso_code_format(code) }

    context "given nil" do
      let(:code) { nil }

      it "does not raise error" do
        expect { subject }.not_to raise_error
      end

      it "returns nil" do
        expect(subject).to eq(nil)
      end

      it "does not call validations" do
        expect(described_class).not_to receive(:check_object_class)
        expect(described_class).not_to receive(:check_string_format)
        subject
      end
    end

    context "given the code is present" do
      let(:code) { :fr }

      it "validates object class" do
        expect(CompanyNumber::Validation).to(
          receive(:check_object_class)
          .with(code, [Symbol, String])
          .exactly(1)
          .times
          .and_call_original
        )

        subject
      end

      it "validates string format" do
        expect(CompanyNumber::Validation).to(
          receive(:check_string_format)
          .with(code.to_s, described_class::ISO_CODE_REGEXP)
          .exactly(1)
          .times
          .and_call_original
        )

        subject
      end
    end
  end

  describe ".check_country_code_metadata" do
    subject { described_class.check_country_code_metadata(metadata) }

    let(:metadata) do
      {
        variations: "foo",
        pattern: "bar",
        country: "baz",
        regexp: "/foo/",
        name: "bar"
      }
    end

    it "validates metadata" do
      expect(CompanyNumber::Validation).to(
        receive(:check_object_inclusion)
        .exactly(metadata.size)
        .times
        .and_call_original
      )

      expect(CompanyNumber::Validation).to(
        receive(:check_object_class)
        .exactly(metadata.size)
        .times
        .and_call_original
      )

      subject
    end
  end
end
