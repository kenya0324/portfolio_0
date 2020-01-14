class Users::PostsController < ApplicationController
  before_action :authenticate_user!

  def index
      @posts = Post.all.order(created_at: :desc)
      @like = Like.new
      @categories = Category.all
      @all_ranks = Post.find(Like.group(:post_id).order('count(post_id) desc').limit(3).pluck(:post_id))

      @post_posts = Post.all.order(created_at: :desc)
      @user = User.find(current_user.id)
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
      @random = Post.order("Random()").last
  end

  def follow_index
      @posts_all = Post.all.order(created_at: :desc)
      @user = User.find(current_user.id)
      @follow_users = @user.followings
      @posts = @posts_all.where(user_id: @follow_users).order("created_at DESC")
      @categories = Category.all
      @like = Like.new
      @all_ranks = Post.find(Like.group(:post_id).order('count(post_id) desc').limit(3).pluck(:post_id))

      @post_posts = Post.all.order(created_at: :desc)
      @user = User.find(current_user.id)
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
      @random = Post.order("Random()").last
  end

  def category
      @category = Category.find(params[:id])
      @post = Post.where(category_id:@category.id).order(created_at: :desc)
      @categories = Category.all
      @like = Like.new
      @all_ranks = Post.find(Like.group(:post_id).order('count(post_id) desc').limit(3).pluck(:post_id))

      @post_posts = Post.all.order(created_at: :desc)
      @user = User.find(current_user.id)
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
      @random = Post.order("Random()").last
  end

  def hashtag
      @user = current_user
      @tag = Hashtag.find_by(hashname: params[:name])
      @posts = @tag.posts.build
      @post  = @tag.posts.page(params[:page]).order(created_at: :desc)
      @categories = Category.all
      @all_ranks = Post.find(Like.group(:post_id).order('count(post_id) desc').limit(3).pluck(:post_id))

      @post_posts = Post.all.order(created_at: :desc)
      @user = User.find(current_user.id)
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
      @random = Post.order("Random()").last
  end

  def search
      @posts = Post.where('posts.post_name LIKE(?)', "%#{params[:search]}%").order(created_at: :desc)
      @categories = Category.all
      @like = Like.new
      @all_ranks = Post.find(Like.group(:post_id).order('count(post_id) desc').limit(3).pluck(:post_id))

      @post_posts = Post.all.order(created_at: :desc)
      @user = User.find(current_user.id)
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
      @random = Post.order("Random()").last
  end

  def show
      @post = Post.find(params[:id])
      @user = User.find_by(id: @post.user_id)
      @comment = Comment.new
      @comments = @post.comments
      @categories = Category.all
      @all_ranks = Post.find(Like.group(:post_id).order('count(post_id) desc').limit(3).pluck(:post_id))

      @post_posts = Post.all.order(created_at: :desc)
      @user = User.find(current_user.id)
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
      @random = Post.order("Random()").last
  end

  def new
      @post = Post.new
  end

  def create
      @post = Post.new(post_params)
      @post.user_id = current_user.id
      respond_to do |format|
       if @post.save!
         format.html { redirect_to @post }
         format.json { render :show, status: :created, location: @post }
         format.js { @status = "success" }
       else
         format.html { render :index }
         format.json { render json: @post.errors, status: :unprocessable_entity }
         format.js { @status = "fail" }
       end
      end
  end

  def edit
  end

 private
  def post_params
      params.require(:post).permit(:user_id, :category_id, :hashtag_id, :post_image, :post_content, :post_name, :url ,:content)
  end
end
