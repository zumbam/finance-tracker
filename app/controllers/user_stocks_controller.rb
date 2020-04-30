class UserStocksController < ApplicationController

  before_action :authenticate_user!

  def create
    ticker = params[:ticker]
    stock = Stock.check_db(ticker)
    if stock.blank?
      stock = Stock.get_stock_price(ticker)
      saved = stock.save()
      if !saved
        flash[:alert] = "Uuuups could not save the stock. Try again"
        redirect_to my_portfolio_path
      end
    end
    current_user.stocks << stock
    flash[:notice] = "The Stock \"#{stock.ticker}\" was successfully added to User"
    redirect_to my_portfolio_path
  end

  def destroy
    stock_id = params[:id]
    user_stock_entry = UserStock.where(stock_id: stock_id, user_id: current_user).first
    destroyed = user_stock_entry.destroy
    if !destroyed
      flash[:alert] = "Could not remove stock"
    else
      flash[:notice] = "Successfully removed stock"
    end
    redirect_to my_portfolio_path
  end

end
