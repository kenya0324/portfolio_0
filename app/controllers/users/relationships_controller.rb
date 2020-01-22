class Users::RelationshipsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]

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
