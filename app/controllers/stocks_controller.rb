class StocksController < ApplicationController
  def search_stock
    if params[:stock].present?
      @stock = Stock.get_stock_price(params[:stock])
      unless @stock.nil?
        respond_to do |format|
          format.js { render partial: 'users/result'}
        end
      else
        respond_to do |format|
          flash.now[:alert] = "Please enter a valid ticker symbol"
          format.js { render partial: 'users/result'}
        end
      end
    else
      respond_to do |format|
        flash.now[:alert] = "Please enter a Ticker to search"
        format.js { render partial: 'users/result'}
      end
    end
  end
end
