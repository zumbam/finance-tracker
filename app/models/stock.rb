class Stock < ApplicationRecord

  has_many :user_stocks
  has_many :user, through: :user_stocks

  validates :name, :ticker, presence: true

  def self.get_stock_price(ticker)
    begin
    client = IEX::Api::Client.new(
      publishable_token: Rails.application.credentials.iexcloud[:publishable],
      # secret_token:  Rails.application.credentials.iexcloud[:secret],
      endpoint: 'https://sandbox.iexapis.com/v1')
      new(ticker: ticker, name: client.company(ticker).company_name, last_price: client.price(ticker))
    rescue => exception
      return nil
    end
  end

  def self.check_db(ticker)
    where(ticker: ticker).first
  end
end
