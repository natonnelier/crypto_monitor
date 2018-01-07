require 'mail'
# require 'dotenv/load'

mailer_options = {
            :address              => "smtp.gmail.com",
            :port                 => 587,
            :user_name            => ENV['EMAIL_SYSTEM'],
            :password             => ENV['EMAIL_SYSTEM_PASSWORD'],
            :authentication       => 'plain',
            :enable_starttls_auto => true
          }

Mail.defaults do
  delivery_method :smtp, mailer_options
end

class Alert

  def initialize opts
    @acx_rate_aud = opts[:acx_rate_aud]
    @acx_rate_euro = opts[:acx_rate_euro]
    @kraken_rate = opts[:kraken_rate]
    @ratio = opts[:ratio]
  end

  def send_email
    body_txt = "ACX rate in AUD: #{@acx_rate_aud}\nACX rate in EUR: #{@acx_rate_euro}\nKraken rate (EUR): #{@kraken_rate}\nRatio: #{@ratio}"
    Mail.deliver do
      from     ENV['EMAIL_SYSTEM']
      to       ENV['EMAIL_USER']
      subject  'Exchange news'
      body     body_txt
    end
  end

  private
  def body_text
    "ACX rate in AUD: #{@acx_rate_aud}\n
     ACX rate in EUR: #{@acx_rate_euro}\n
     Kraken rate (EUR): #{@kraken_rate}\n
     Ratio: #{@ratio}"
  end

end
