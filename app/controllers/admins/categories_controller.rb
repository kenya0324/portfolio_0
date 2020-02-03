class Admins::CategoriesController < ApplicationController

    def index
		@categories = Category.all
	end

	def new
        @category = Category.new
    end

    def create
        @category = Category.new(category_params)
        if @category.save
           render :create
        else
           render :create_error
        end
    end

	private

    def category_params
        params.require(:category).permit(:name)
    end
end
