module Stopwords

  class Filter

    attr_reader :stopwords

    def initialize stopwords
      raise ArgumentError, "stopwords must be an Array" unless stopwords.is_a?(Array)
      unless stopwords.all? { |w| w.is_a?(String) }
        raise ArgumentError, "all stopwords must be Strings"
      end
      @stopwords = stopwords.map(&:downcase)
    end

    def filter words
      words.reject{ |word| stopword?(word) }
    end

    def stopword? word
      stopwords.include?(word.downcase)
    end

  end

end
