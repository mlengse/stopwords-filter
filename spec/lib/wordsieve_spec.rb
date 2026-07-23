# encoding: utf-8

require_relative('../spec_helper')

describe Stopwords::Snowball::WordSieve do
  subject { Stopwords::Snowball::WordSieve.new }
  let(:words) { 'guide by douglas adams'.split }

  describe '#filter' do
    it('should remove the stopwords from the list of words') do
      expect(subject.filter(lang: :en, words: words)).to eq(%w[guide douglas adams])
    end

    it('should raise ArgumentError for unknown language') do
      expect { subject.filter(lang: :zz, words: words) }.to raise_error(ArgumentError, /Unknown language/)
    end

    it('should return words unchanged when no lang specified') do
      expect(subject.filter(words: words)).to eq(words)
    end

    it('should filter German stopwords') do
      expect(subject.filter(lang: :de, words: 'das ist ein test'.split)).to eq(%w[test])
    end

    it('should filter Spanish stopwords') do
      expect(subject.filter(lang: :es, words: 'esto es una prueba'.split)).to eq(%w[prueba])
    end
  end

  describe '#stopword?' do
    it('should return true for stopwords') do
      expect(subject.stopword?(lang: :en, word: 'by')).to be_truthy
    end

    it('should return false for non-stopwords') do
      expect(subject.stopword?(lang: :en, word: 'douglas')).to be false
    end

    it('should raise ArgumentError for unknown language') do
      expect { subject.stopword?(lang: :zz, word: 'test') }.to raise_error(ArgumentError, /Unknown language/)
    end

    it('should return false when no lang specified') do
      expect(subject.stopword?(word: 'by')).to be false
    end
  end
end
