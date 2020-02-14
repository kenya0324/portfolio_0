class Users::PostsController < ApplicationController
  before_action :authenticate_user!, only: [:follow_index, :new, :create, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]
  before_action :set_post_all, only: [:index, :category, :hashtag, :search, :show,]
  before_action :set_like, only: [:index, :follow_index, :category, :search]
  before_action :set_category, only: [:index, :follow_index, :category, :hashtag, :search, :show,]
  before_action :set_all_rank, only: [:index, :follow_index, :category, :hashtag, :search, :show]
  before_action :set_recommend_post, only: [:index, :follow_index, :category, :hashtag, :search, :show]

  def index
  end

  def follow_index
      @posts_all = Post.all.order(created_at: :desc)
      @user = User.find(current_user.id)
      @follow_users = @user.followings
      @posts = @posts_all.where(user_id: @follow_users).order("created_at DESC")
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

  def search
      @post_search = Post.where(['posts.post_name  LIKE(?) OR posts.post_content LIKE(?)', "%#{params[:search]}%","%#{params[:search]}%"]).order(created_at: :desc)
  end

  def show
      @post = Post.find(params[:id])
      @user = User.find_by(id: @post.user_id)
      @comment = Comment.new
      @comments = @post.comments
  end

  def new
      @post = Post.new
  end

  def create
      @post = Post.new(post_params)
      @post.user_id = current_user.id
      hashtags  = @post.post_content.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
      hashtags.uniq.map do |hashtag|
        tag = Hashtag.find_or_create_by(hashname: hashtag.downcase.delete('#'))
        tag.save
        @post.hashtags << tag
      end
      if @post.save
         render :create
      else
         render :create_error
      end
  end

  def edit
      @post = Post.find(params[:id])
  end

  def update
      @post = Post.find(params[:id])
      @post.user_id = current_user.id
      @post.hashtags.clear
      hashtags  = params[:post][:post_content].scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
      hashtags.uniq.map do |hashtag|
        tag = Hashtag.find_or_create_by(hashname: hashtag.downcase.delete('#'))
        @post.hashtags << tag
      end
      if @post.update(post_params)
         render :update
      else
         render :update_error
      end
  end

  def destroy
      @post = Post.find(params[:id])
      @user = User.find(current_user.id)
      @post.destroy
      redirect_to users_user_path(@user)
  end


  private

  def post_params
      params.require(:post).permit(:user_id, :category_id, :hashtag_id, :post_image, :post_content, :post_name, :url ,:content)
  end

  def correct_user
      @post = current_user.posts.find_by(id: params[:id])
      unless @post
        redirect_to root_url
      end
  end

  def set_post_all
      @posts = Post.page(params[:page]).per(12).order(created_at: :desc)
  end

  def set_like
      @like = Like.new
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
             @random = Post.order("Random()").last
             @posts = Post.all.order(created_at: :desc)
          end
        else
          if @random != nil
            @random = Post.order("Random()").last
            @posts = Post.all.order(created_at: :desc)
          else
            @random = "1"
            p @random
          end
        end
      else
        if @random != nil
          @random = Post.order("Random()").last
        else
          @random = "1"
          p @random
        end
      end
  end
end
