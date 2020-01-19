class Users::RelationshipsController < ApplicationController
  def create
      @user = User.find(params[:following_id])
      current_user.follow!(@user)
      @user.create_notification_follow!(current_user)
      respond_to do |format|
        format.html { redirect_to @user }
        format.js
      end
  end

  def destroy
      @user = User.find(params[:id])
      current_user.unfollow!(@user)
      render :destroy
  end

end
