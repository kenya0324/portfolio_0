class Users::UsersController < ApplicationController
  def show
  	  @user = User.find(params[:id])
      @like = Like.new
  end

  def edit
  	  @user = User.find(params[:id])
  end

  def update
  	  @user = User.find(params[:id])
      respond_to do |format|
       if @user.update(user_params)
         format.html { redirect_to @user}
         format.json { render :show, status: :ok, location: @user }
         format.js { @status = "success"}
       else
         format.html { render :show }
         format.json { render json: @user.errors, status: :unprocessable_entity }
         format.js { @status = "fail" }
       end
      end

  end

  def destroy
      @user = User.find(params[:id])
      @user.destroy
      redirect_to posts_path
  end

  def following
      @user  = User.find(params[:id])
      @users = @user.followings
      render 'show_follow'
  end

  def followers
      @user  = User.find(params[:id])
      @users = @user.followers
      render 'show_follower'
  end

  def want
      @user = User.find(params[:id])
      @like = Like.new
  end

 private
  def user_params
      params.require(:user).permit(:name, :email, :user_image)
  end

end
