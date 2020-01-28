class Users::NotificationsController < ApplicationController
	def index
        @notifications = current_user.passive_notifications
        @notifications.where(checked: false).each do |notification|
          notification.update_attributes(checked: true)
        end
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

  def destroy_all
      @notifications = current_user.passive_notifications.destroy_all
      redirect_to users_notifications_path
  end

end
