class FriendshipsController < ApplicationController

  before_action :authenticate_user!

  def create
    friend_id = params[:friend_id]
    possible_friend = User.find(friend_id)
    friendship =  Friendship.where(user: current_user, friend: possible_friend).first
    if friendship.nil?
      current_user.friends << possible_friend
      flash['notice'] = 'Friendship successfully created'
    else
      flash['alert'] = 'Friendship already exists'
    end
    redirect_to my_friends_path
  end

  def destroy
    params_present?
    friend_id = params[:id]
    possible_friend = User.find(friend_id)
    friendship =  Friendship.where(user: current_user, friend: possible_friend).first
    if friendship.nil?
      flash['alert'] = 'Friendship does not exists'
    else
      destroyed = friendship.destroy
      if destroyed
        flash['notice'] = 'Friendship successfully destoyed'
      else
        flash['alert'] = 'Uuuup could not destroy friendship'
      end

    end
    redirect_to my_friends_path
  end

  def params_present?
    friend_id = params[:id]
    unless friend_id.present?
      flash['alert'] = 'Invalid friend id'
      redirect_to my_friends_path
    end
  end
end
