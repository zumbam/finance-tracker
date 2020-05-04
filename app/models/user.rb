class User < ApplicationRecord

  STOCK_LIMIT = 10
  has_many :user_stocks
  has_many :stocks, through: :user_stocks
  has_many :friendships
  has_many :friends, through: :friendships
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

  def fullname
    if firstname.empty? || lastname.empty?
      "Anonymous"
    else
      "#{firstname} #{lastname}"
    end
  end

  def self.to_email_wildcard(pattern)
    "%#{pattern}%@%"
  end
  def self.to_name_wildcard(pattern)
    "%#{pattern}%"
  end

  def self.find_user_by_name(name)
    name = name.strip
    email_pattern = to_email_wildcard(name)
    email_hits = where("email like ?", email_pattern)

    name_pattern =to_name_wildcard(name)
    firstname_hits = where("firstname like ?", name_pattern)
    lastname_hits = where("lastname like ?", name_pattern)
    (email_hits + firstname_hits + lastname_hits).uniq
  end

  def except_current_user(user_list)
    user_list - [self]
  end

  def except_friends(user_list)
    user_list - friends
  end

end
