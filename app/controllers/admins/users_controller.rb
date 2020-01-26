class Admins::UsersController < ApplicationController
	before_action :set_category, only: [:index, :category, :hashtag, :search, :show,]

	def index
        @users = User.all.order(created_at: :desc)
	end

	def show
  	    @user = User.find(params[:id])
    end

  private

  def user_params
      params.require(:user).permit(:user_id, :category_id, :hashtag_id, :post_image, :post_content, :post_name, :url ,:content)
  end

  def set_category
      @categories = Category.all
  end

end
