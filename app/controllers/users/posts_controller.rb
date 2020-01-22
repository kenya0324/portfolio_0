class Users::PostsController < ApplicationController
  before_action :authenticate_user!, only: [:follow_index, :new, :create, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def index
      @posts = Post.all.order(created_at: :desc)
      @like = Like.new
      @categories = Category.all
      @all_ranks = Post.find(Like.group(:post_id).order('count(post_id) desc').limit(3).pluck(:post_id))
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
        @random = Post.order("Random()").last
        @posts = Post.all.order(created_at: :desc)
      end
    else
      @random = Post.order("Random()").last
    end
  end

  def follow_index
      @posts_all = Post.all.order(created_at: :desc)
      @user = User.find(current_user.id)
      @follow_users = @user.followings
      @posts = @posts_all.where(user_id: @follow_users).order("created_at DESC")
      @categories = Category.all
      @like = Like.new
      @all_ranks = Post.find(Like.group(:post_id).order('count(post_id) desc').limit(3).pluck(:post_id))

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
        @random = Post.order("Random()").last
        @posts = Post.all.order(created_at: :desc)
      end
    else
      @random = Post.order("Random()").last
    end
  end

  def category
      @posts = Post.all.order(created_at: :desc)
      @category = Category.find(params[:id])
      @post = Post.where(category_id:@category.id).order(created_at: :desc)
      @categories = Category.all
      @like = Like.new
      @all_ranks = Post.find(Like.group(:post_id).order('count(post_id) desc').limit(3).pluck(:post_id))
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
        @random = Post.order("Random()").last
        @posts = Post.all.order(created_at: :desc)
      end
    else
      @random = Post.order("Random()").last
    end
  end

  def hashtag
      @posts = Post.all.order(created_at: :desc)
      @user = current_user
      @tag = Hashtag.find_by(hashname: params[:name])
      @post_tag = @tag.posts.build
      @post  = @tag.posts.page(params[:page]).order(created_at: :desc)
      @categories = Category.all
      @all_ranks = Post.find(Like.group(:post_id).order('count(post_id) desc').limit(3).pluck(:post_id))
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
        @random = Post.order("Random()").last
        @posts = Post.all.order(created_at: :desc)
      end
    else
      @random = Post.order("Random()").last
    end
  end

  def search
      @posts = Post.all.order(created_at: :desc)
      @post_search = Post.where('posts.post_name LIKE(?)', "%#{params[:search]}%").order(created_at: :desc)
      @categories = Category.all
      @like = Like.new
      @all_ranks = Post.find(Like.group(:post_id).order('count(post_id) desc').limit(3).pluck(:post_id))
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
        @random = Post.order("Random()").last
        @posts = Post.all.order(created_at: :desc)
      end
    else
      @random = Post.order("Random()").last
    end
  end

  def show
      @posts = Post.all.order(created_at: :desc)
      @post = Post.find(params[:id])
      @user = User.find_by(id: @post.user_id)
      @comment = Comment.new
      @comments = @post.comments
      @categories = Category.all
      @all_ranks = Post.find(Like.group(:post_id).order('count(post_id) desc').limit(3).pluck(:post_id))
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
        @random = Post.order("Random()").last
        @posts = Post.all.order(created_at: :desc)
      end
    else
      @random = Post.order("Random()").last
    end
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
      @post = Post.find(params[:id])
  end

  def update
      @post = Post.find(params[:id])
      respond_to do |format|
       if @post.update(post_params)
         format.html { redirect_to @post}
         format.json { render :show, status: :ok, location: @post }
         format.js { @status = "success"}
       else
         format.html { render :show }
         format.json { render json: @post.errors, status: :unprocessable_entity }
         format.js { @status = "fail" }
       end
      end
  end

  def destroy
      @user = User.find(current_user.id)
      post = Post.find(params[:id])
      post.destroy
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
end
