class Users::UsersController < ApplicationController
  def show
      @posts = Post.all.order(created_at: :desc)
  	  @user = User.find(params[:id])
      @like = Like.new
      @categories = Category.all
      @all_ranks = Post.find(Like.group(:post_id).order('count(post_id) desc').limit(3).pluck(:post_id))

    if current_user.likes.exists?
      @post_posts = Post.all.order(created_at: :desc)
      like = current_user.likes.last

      post = like.post
      category_recommend = Category.find_by(name: post.category.name)
      post_recommend = category_recommend.posts
      likes = Like.where(user_id: @user.id)
      x = []
      likes.each do |like|
        x << like.post_id
      end
      @likes_recommend = post_recommend.where.not(id: x)
    else
      @random = Post.order("Random()").last
    end
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
      @posts = Post.all.order(created_at: :desc)
      @user  = User.find(params[:id])
      @users = @user.followings
      @categories = Category.all
      @all_ranks = Post.find(Like.group(:post_id).order('count(post_id) desc').limit(3).pluck(:post_id))

    if current_user.likes.exists?
      @post_posts = Post.all.order(created_at: :desc)
      @user = current_user
      like = current_user.likes.last

      post = like.post
      category_recommend = Category.find_by(name: post.category.name)
      post_recommend = category_recommend.posts
      likes = Like.where(user_id: @user.id)
      x = []
      likes.each do |like|
        x << like.post_id
      end
      @likes_recommend = post_recommend.where.not(id: x)
    else
      @random = Post.order("Random()").last
    end
      render 'following'
  end

  def followers
      @posts = Post.all.order(created_at: :desc)
      @user  = User.find(params[:id])
      @users = @user.followers
      @categories = Category.all
      @all_ranks = Post.find(Like.group(:post_id).order('count(post_id) desc').limit(3).pluck(:post_id))

    if current_user.likes.exists?
      @post_posts = Post.all.order(created_at: :desc)
      @user = current_user
      like = current_user.likes.last

      post = like.post
      category_recommend = Category.find_by(name: post.category.name)
      post_recommend = category_recommend.posts
      likes = Like.where(user_id: @user.id)
      x = []
      likes.each do |like|
        x << like.post_id
      end
      @likes_recommend = post_recommend.where.not(id: x)
    else
      @random = Post.order("Random()").last
    end
      render 'follower'
  end

  def want
      @posts = Post.all.order(created_at: :desc)
      @user = User.find(params[:id])
      @like = Like.new
      @categories = Category.all
      @all_ranks = Post.find(Like.group(:post_id).order('count(post_id) desc').limit(3).pluck(:post_id))

    if current_user.likes.exists?
      @post_posts = Post.all.order(created_at: :desc)
      @user = current_user
      like = current_user.likes.last

      post = like.post
      category_recommend = Category.find_by(name: post.category.name)
      post_recommend = category_recommend.posts
      likes = Like.where(user_id: @user.id)
      x = []
      likes.each do |like|
        x << like.post_id
      end
      @likes_recommend = post_recommend.where.not(id: x)
    else
      @random = Post.order("Random()").last
    end
  end

 private
  def user_params
      params.require(:user).permit(:name, :email, :introduction, :user_image)
  end

end
