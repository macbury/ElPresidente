module Meme
  class Slang < Service
    use Scrape::Html, as: :query_elements

    def initialize(internet: nil)
      @internet = internet || Async::HTTP::Internet.new
    end

    def call
      word, description = query_elements(internet: internet, url: 'https://www.miejski.pl/losuj', css_query: '#content > main > article > header > h1, #content > main > article p')

      {
        word: word.text.strip,
        description: description.text.strip
      }
    end

    private

    attr_reader :internet
  end
end