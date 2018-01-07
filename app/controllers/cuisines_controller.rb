class CuisinesController < ApplicationController
	def show
		@cuisine = Cuisine.find(params[:id])
		@recipes = Recipe.where('cuisine_id = ?' , @cuisine)
	end

	def create
		cuisine_params = params.require(:cuisine).permit(:name)
		@cuisine = Cuisine.new(cuisine_params)

		if @cuisine.valid?
			@cuisine.save
			redirect_to @cuisine
		else
			render new_cuisine_path
		end
	end

	def new
		@cuisine = Cuisine.new
	end
end