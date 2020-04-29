class Stock < ApplicationRecord

  def self.get_stock_price(ticker)
    begin
    client = IEX::Api::Client.new(
      publishable_token: Rails.application.credentials.iexcloud[:publishable],
      # secret_token:  Rails.application.credentials.iexcloud[:secret],
      endpoint: 'https://sandbox.iexapis.com/v1')
      Stock.new(ticker: ticker, name: client.company(ticker).company_name, last_price: client.price(ticker))
    rescue => exception
      return nil
    end
  end
end
