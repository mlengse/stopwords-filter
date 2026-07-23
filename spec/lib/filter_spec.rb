require_relative("../spec_helper.rb")

describe Stopwords::Filter do

  context "when fed with a list of arbitrary words" do

    let (:filter) { Stopwords::Filter.new stopwords }
    let (:stopwords) { ["A", "desde"] }

    subject { filter }

    it("should remove the stopwords for the list of words to be filtered") { expect(filter.filter("desde Santurce A Bilbao".split)).to eq ["Santurce", "Bilbao"]}
    it("should remove stopwords even if upcase and downcases doesn't match") { expect(filter.filter("Desde Santurce a Bilbao".split)).to eq ["Santurce", "Bilbao"]}

  end

  context "#stopword?" do
    let (:filter) { Stopwords::Filter.new ["by", "from"] }

    it("returns true for stopwords") { expect(filter.stopword?("by")).to be true }
    it("returns true for stopwords case-insensitively") { expect(filter.stopword?("BY")).to be true }
    it("returns false for non-stopwords") { expect(filter.stopword?("unknown")).to be false }
  end

  context "with edge cases" do
    it("raises ArgumentError for nil input") { expect { Stopwords::Filter.new(nil) }.to raise_error(ArgumentError) }
    it("raises ArgumentError for non-array input") { expect { Stopwords::Filter.new("by") }.to raise_error(ArgumentError) }
    it("raises ArgumentError for non-string elements") { expect { Stopwords::Filter.new([123]) }.to raise_error(ArgumentError) }
    it("handles empty array") { expect(Stopwords::Filter.new([]).filter(["hello"])).to eq(["hello"]) }
    it("handles single word input") { expect(Stopwords::Filter.new(["by"]).filter(["by"])).to eq([]) }
  end

end
