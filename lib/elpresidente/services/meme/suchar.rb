module Meme
  class Suchar < Service
    use Scrape::Html, as: :query_elements

    def initialize(internet: nil)
      @internet = internet || Async::HTTP::Internet.new
    end

    def call
      link, showtxt = query_elements(internet: internet, url: 'https://sucharry.pl/losuj', css_query: '.suchar > a.link, .suchar > .showtxt')

      raise ServiceFailure, 'Could not fetch a sucharr' unless link

      if showtxt
        {
          text: link.text,
          punchline: showtxt['data-txt']
        }
      else
        {
          text: link.text
        }
      end
    end

    private

    attr_reader :internet
  end
end