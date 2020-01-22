class Users::CommentsController < ApplicationController
    before_action :authenticate_user!, only: [:create, :destroy]

	  def create
        @post = Post.find(params[:post_id])
        @comment = @post.comments.build(comment_params)
        @comment.user_id = current_user.id
        if @comment.save
          @post.create_notification_comment(current_user, @comment.id)
          render :index
        else
          render 'users/posts/show'
        end
    end

    def destroy
        @comment = Comment.find(params[:id])
        if @comment.destroy
          render :index
        end
    end

  private
    def comment_params
        params.require(:comment).permit(:content, :post_id, :user_id)
    end
end
