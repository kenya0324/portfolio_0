class Admins::PostsController < ApplicationController
  before_action :authenticate_admin!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_post_all, only: [:index, :category, :hashtag, :hashtag_all, :search, :show,]
  before_action :set_category, only: [:index, :category, :hashtag, :hashtag_all, :search, :show,]

  def index
  end

  def category
      @category = Category.find(params[:id])
      @post = Post.where(category_id:@category.id).order(created_at: :desc)
  end

  def hashtag
      @user = current_user
      @tag = Hashtag.find_by(hashname: params[:name])
      @post_tag = @tag.posts.build
      @post  = @tag.posts.page(params[:page]).order(created_at: :desc)
  end

  def hashtag_all
      @hashtags = Hashtag.all
  end

  def search
      @post_search = Post.where('posts.post_name LIKE(?)', "%#{params[:search]}%").order(created_at: :desc)
  end

  def show
      @post = Post.find(params[:id])
      @user = User.find_by(id: @post.user_id)
      @comment = Comment.new
      @comments = @post.comments
  end

  def destroy
      @post = Post.find(params[:id])
      @user = User.find(current_user.id)
      @post.destroy
      redirect_to admins_posts_path
  end


 private

  def post_params
      params.require(:post).permit(:user_id, :category_id, :hashtag_id, :post_image, :post_content, :post_name, :url ,:content)
  end

  def set_post_all
      @posts = Post.all.order(created_at: :desc)
  end

  def set_category
      @categories = Category.all
  end

end
