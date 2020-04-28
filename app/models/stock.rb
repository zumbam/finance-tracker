class Stock < ApplicationRecord
  def self.get_stock_price(ticker)

    client = IEX::Api::Client.new(
      publishable_token: Rails.application.credentials.iexcloud[:publishable],
      # secret_token:  Rails.application.credentials.iexcloud[:secret],
      endpoint: 'https://sandbox.iexapis.com/v1')
    client.price(ticker)
  end
end
