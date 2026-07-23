module Stopwords
  module Snowball
    class WordSieve
      def initialize(custom_list = [])
        @filters = Dir["#{File.dirname(__FILE__)}/locales/*.csv"].each_with_object({}) do |file, filters|
          lang = File.basename(file, '.csv')
          filters[lang.to_sym] = Stopwords::Snowball::Filter.new lang, custom_list
        end
      end

      def stopword?(args = {})
        return false unless args[:lang]
        raise ArgumentError, "Unknown language: #{args[:lang].inspect}" unless @filters.key?(args[:lang])
        @filters[args[:lang]].stopword?(args[:word])
      end

      def filter(args = {})
        return args[:words] unless args[:lang]
        raise ArgumentError, "Unknown language: #{args[:lang].inspect}" unless @filters.key?(args[:lang])
        @filters[args[:lang]].filter(args[:words])
      end
    end
  end
end
