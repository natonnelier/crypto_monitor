require 'roda'
require 'json'
require 'sequel'


class CryptoMonitor < Roda
  Sequel::Model.plugin :json_serializer
  require './lib/mailer/alert'
  require './lib/crypto_monitor/ethereum_monitor'

  route do |r|
    r.root do
    end
  end
end
