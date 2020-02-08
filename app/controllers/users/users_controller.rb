class Users::UsersController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]
  before_action :set_post_all, only: [:show, :following, :followers, :want]
  before_action :set_category, only: [:show, :following, :followers, :want]
  before_action :set_all_rank, only: [:show, :following, :followers, :want]
  before_action :set_recommend_post, only: [:show, :following, :followers, :want]

  def show
  	  @user = User.find(params[:id])
      @like = Like.new
  end

  def edit
  	  @user = User.find(params[:id])
  end

  def update
  	  @user = User.find(params[:id])
      if @user.update(user_params)
         render :update
      else
         render :update_error
      end
  end

  def hide
      @user = User.find(params[:id])
      @user.update(is_deleted: true)
      session.delete(:user)
      flash[:notice] = "ありがとうございました。またのご利用を心よりお待ちしてお待ちしております"
      redirect_to root_path
  end

  def following
      @user  = User.find(params[:id])
      @users = @user.followings
      render 'following'
  end

  def followers
      @user  = User.find(params[:id])
      @users = @user.followers
      render 'follower'
  end

  def want
      @user = User.find(params[:id])
      @like = Like.new
  end

 private

  def user_params
      params.require(:user).permit(:name, :email, :introduction, :user_image)
  end

  def correct_user
      @user = User.find(params[:id])
      if current_user != @user
        redirect_to root_path
      end
  end

  def set_post_all
      @posts = Post.all.order(created_at: :desc)
  end

  def set_category
      @categories = Category.all
  end

  def set_all_rank
      @all_ranks = Post.find(Like.group(:post_id).order('count(post_id) desc').limit(3).pluck(:post_id))
  end

  def set_recommend_post
      if user_signed_in?
        if current_user.likes.exists?
          @post_posts = Post.all.order(created_at: :desc)
          @user = current_user
          like = @user.likes.last
          post = like.post
          category_recommend = Category.find_by(name: post.category.name)
          post_recommend = category_recommend.posts
          likes = Like.where(user_id: @user.id)
          x = []
          likes.each do |like|
            x << like.post_id
          end
          @likes_recommend = post_recommend.where.not(id: x)
          if @likes_recommend.blank?
             @random = Post.order("RAND()").last
             @posts = Post.all.order(created_at: :desc)
          end
        else
          if @random != nil
            @random = Post.order("RAND()").last
            @posts = Post.all.order(created_at: :desc)
          else
            @random = "1"
            p @random
          end
        end
      else
        if @random != nil
          @random = Post.order("RAND()").last
        else
          @random = "1"
          p @random
        end
      end
  end

end
