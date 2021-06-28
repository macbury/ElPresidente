module Meme
  class Tvp < Service
    ENDPOINT_URL = 'https://pasek-tvpis.pl/'

    def initialize(internet: nil, message:)
      @internet = internet || Async::HTTP::Internet.new
      @message = message
    end

    def call
      response = internet.post ENDPOINT_URL, headers, ["msg=#{message}"]
      URI.join(ENDPOINT_URL, response.headers['location']).to_s   
    end

    private

    attr_reader :internet, :message

    def headers
      {
        "accept" => "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9",
        "accept-language" => "pl-PL,pl;q=0.9,en-US;q=0.8,en;q=0.7",
        "cache-control" => "no-cache",
        "content-type" => "application/x-www-form-urlencoded",
        "pragma" => "no-cache",
        "sec-fetch-dest" => "document",
        "sec-fetch-mode" => "navigate",
        "sec-fetch-site" => "same-origin",
        "sec-fetch-user" => "?1",
        "sec-gpc" => "1",
        "upgrade-insecure-requests" => "1"
      }
    end
  end
end