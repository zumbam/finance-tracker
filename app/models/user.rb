class User < ApplicationRecord

  STOCK_LIMIT = 10
  has_many :user_stocks
  has_many :stocks, through: :user_stocks
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  def tracks_stock?(ticker)
    stocks.where(ticker: ticker).exists?
  end

  def reached_limit?
    stocks.all.count >= STOCK_LIMIT
  end

  def can_track_stock?(ticker)
    !tracks_stock?(ticker) && !reached_limit?
  end
end
