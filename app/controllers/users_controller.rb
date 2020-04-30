class UsersController < ApplicationController

  before_action :authenticate_user!, only: [:my_portfolio]

  def my_portfolio
    @stocks = current_user.stocks
  end
end
