require 'nokogiri'
require 'open-uri'
require 'byebug'


module CurrencyExchange

  def self.aus_to_eur
    doc = Nokogiri::HTML(open('https://transferwise.com/us/currency-converter/aud-to-eur-rate?amount=1'))
    doc.css('.text-success[data-rate]').text.to_f
  end

end
