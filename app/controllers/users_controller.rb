class UsersController < ApplicationController

  MAX_NUMBER_OF_REULTS = 10

  before_action :authenticate_user!

  def my_portfolio
    @stocks = current_user.stocks
  end

  def my_friends
    @friends = current_user.friends
  end

  def show
    @user = User.find(params[:id])
  end

  def search_friends
    friend_search_input = params[:friend_search_input]
    if friend_search_input.present?
      possible_user_list = User.find_user_by_name(friend_search_input)
      possible_user_list = current_user.except_current_user(possible_user_list)
      possible_user_list = current_user.except_friends(possible_user_list)
      if possible_user_list.empty?
        flash.now['notice'] = 'could not find user with this name'
      else
        @user_hits = possible_user_list[0..MAX_NUMBER_OF_REULTS]
      end
    else
      flash.now['alert'] = 'please enter a valid friend name'
    end

    respond_to do |format|
      format.js { render partial: 'friend_search'}
    end
  end

end
