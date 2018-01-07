namespace :exchanges do
  desc "Kraken vs ACX ethereum exchange rates"
  task kraken_acx_alert: :app do
    client = EthereumMonitor::KrakenToAcx.new
    client.check_ratio
    puts "Sent"
  end
end
