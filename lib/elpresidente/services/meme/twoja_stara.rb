module Meme
  class TwojaStara < Service
    use Scrape::Html, as: :query_elements

    def initialize(internet: nil)
      @internet = internet || Async::HTTP::Internet.new
    end

    def call
      pages = query_elements(internet: internet, url: 'http://www.hss.pl/dowcipy/twoja-stara/0/', css_query: 'table td center a').to_a

      next_page_url = URI.join('http://www.hss.pl/', pages.sample[:href]).to_s
      jokes = query_elements(internet: internet, url: next_page_url, css_query: 'td[colspan="6"]').to_a
      jokes.sample.text
    end

    private

    attr_reader :internet
  end
end