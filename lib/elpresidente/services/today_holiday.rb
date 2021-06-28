class TodayHoliday < Service
  use Scrape::Html, as: :query_elements

  def initialize(internet: nil)
    @internet = internet || Async::HTTP::Internet.new
  end

  def call
    holidays = query_elements(internet: internet, url: 'https://www.kalbi.pl/', css_query: '.calCard-ententa a')

    holidays.map { |h| h.text.strip }
  end

  private

  attr_reader :internet
end