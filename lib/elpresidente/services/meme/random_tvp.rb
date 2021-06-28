module Meme
  class RandomTvp < Service
    use LoadSpreadsheet, as: :load_spreadsheet
    use Tvp, as: :generate_image_url

    def initialize(internet: nil)
      @internet = internet || Async::HTTP::Internet.new
    end

    def call
      worksheet = load_spreadsheet(ENV.fetch('TVP_PASKI_ID'))
      message = worksheet.rows.map { |row| row[0] }.sample

      generate_image_url(internet: internet, message: message)
    end

    private

    attr_reader :internet
  end
end