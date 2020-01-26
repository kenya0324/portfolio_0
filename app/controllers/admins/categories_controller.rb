class Admins::CategoriesController < ApplicationController

    def index
		    @categories = Category.all
	  end


	  def new
        @category = Category.new
    end

    def create
        @category = Category.new(category_params)
        respond_to do |format|
         if @category.save!
           format.html { redirect_to @category }
           format.json { render :show, status: :created, location: @category }
           format.js { @status = "success" }
         else
           format.html { render :index }
           format.json { render json: @category.errors, status: :unprocessable_entity }
           format.js { @status = "fail" }
         end
        end
    end

	private

    def category_params
        params.require(:category).permit(:name)
    end
end
