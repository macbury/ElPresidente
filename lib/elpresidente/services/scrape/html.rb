module Scrape
  class Html < Service
    use ResolveUrl, as: :resolve_url

    def initialize(url:, css_query:, internet: nil)
      @internet = internet || Async::HTTP::Internet.new
      @url = url
      @css_query = css_query
    end

    def call
      final_url = resolve_url(url, internet: internet)
      response = internet.get final_url

      doc = Nokogiri::HTML(response.read)
      doc.search(css_query)
    end

    private

    attr_reader :internet, :url, :css_query
  end
end