class Users::RelationshipsController < ApplicationController
  def create
      @user = User.find(params[:following_id])
      current_user.follow!(@user)
      @user.create_notification_follow(current_user)
      render :create
  end

  def destroy
      @user = User.find(params[:id])
      current_user.unfollow!(@user)
      render :destroy
  end

end
