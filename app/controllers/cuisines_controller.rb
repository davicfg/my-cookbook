class CuisinesController < ApplicationController
	def show
		@cuisine = Cuisine.find(params[:id])
		@recipes = Recipe.where('cuisine_id = ?' , @cuisine)
	end

end