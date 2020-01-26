class Admins::HashtagsController < ApplicationController
  before_action :authenticate_admin!, only: [:index, :destroy]
  before_action :set_category, only: [:index]

  def index
  	  @hashtags = Hashtag.all
  end

  def destroy
      @hashtag = Hashtag.find(params[:id])
      @hashtag.destroy
      redirect_to admins_hashtags_path
      binding.pry
  end


 private

  def hashtag_params
      params.require(:hashtag).permit(:hashtag_id)
  end

  def set_category
      @categories = Category.all
  end

end
