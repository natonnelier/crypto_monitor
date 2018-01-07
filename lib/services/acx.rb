require 'httparty'

module ACX
  class Client
    include HTTParty

    def initialize(api_key=nil, api_secret=nil, options={})
      @api_key      = api_key
      @api_secret   = api_secret
      @api_version  = options[:version] ||= 'v2/'
      @base_uri     = options[:base_uri] ||= 'https://acx.io/api/'
    end

    def self.ticker_rate(pairs)
      acx_ticker = ACX::Client.new().ticker("ethaud")
      acx_ticker["buy"].to_f
    end

    def ticker(pairs)
      response = self.class.get(target_endpoint('tickers/', pairs))
      response["ticker"]
    end

    private
    def target_endpoint(method, pairs)
      @base_uri + @api_version + method + pairs + ".json"
    end
  end
end
