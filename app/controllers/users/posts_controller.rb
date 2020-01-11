class Users::PostsController < ApplicationController
  before_action :authenticate_user!

  def index
      @posts = Post.all
      @like = Like.new
      @categories = Category.all
  end

  def category
      @category = Category.find(params[:id])
      @post = Post.where(category_id:@category.id)
      @categories = Category.all
      @like = Like.new
  end

  def hashtag
      @user = current_user
      @tag = Hashtag.find_by(hashname: params[:name])
      @posts = @tag.posts.build
      @post  = @tag.posts.page(params[:page])
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
      params.require(:post).permit(:user_id, :category_id, :post_image, :post_content, :post_name, :url ,:content)
  end
end
