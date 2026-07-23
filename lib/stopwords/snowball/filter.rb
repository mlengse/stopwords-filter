require 'csv'

module Stopwords
  module Snowball
    class Filter < Stopwords::Filter
      attr_reader :locale
      attr_reader :locale_filename

      LOCALE_REDIRECTS = {
        "fn" => "fi"
      }.freeze

      def initialize locale, custom_list = []
        @locale = locale.gsub(/-\w+/, '') # remove country appendix
        @locale = LOCALE_REDIRECTS.fetch(@locale, @locale)
        @locale_filename = "#{File.dirname(__FILE__)}/locales/#{@locale}.csv"

        raise ArgumentError.new("Unknown locale: #{locale.inspect}") unless File.exist?(@locale_filename)
        words = CSV.parse_line(File.read(@locale_filename)) || []
        words.reject! { |w| w.nil? || w.empty? }
        super words + custom_list
      end
    end
  end
end
