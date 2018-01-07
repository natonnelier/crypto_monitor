require './lib/services/currency_exchange'
require './lib/services/acx'
require './lib/services/kraken'

RATIO_LIMIT = ENV['RATIO_LIMIT'].to_f

module EthereumMonitor
  class KrakenToAcx

    def initialize
      @kraken_rate = Kraken::Client.ticker_rate('ETHEUR')
      @acx_rate_aud = ACX::Client.ticker_rate("ethaud")
      @acx_rate_euro = @acx_rate_aud * CurrencyExchange.aus_to_eur
    end

    def ratio
      ((@acx_rate_euro / @kraken_rate)-1)*100
    end

    def check_ratio
      if ratio > RATIO_LIMIT
        opts = {
          acx_rate_aud: @acx_rate_aud,
          acx_rate_euro: @acx_rate_euro,
          kraken_rate: @kraken_rate,
          ratio: ratio
        }
        Alert.new(opts).send_email
      end
    end
  end
end
