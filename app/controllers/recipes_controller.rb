class RecipesController < ApplicationController
	def show
		@recipe = Recipe.find(params[:id])
	end
	def new
		@cuisines = Cuisine.all
		@recipe = Recipe.new 		
	end

	def create
		recipe_params = params.require(:recipe).permit(:title, 
			:recipe_type, :cuisine_id, :difficulty, 
			:cook_time, :ingredients, :method )
		@recipe = Recipe.new(recipe_params)

		if @recipe.valid?
			@recipe.save
			redirect_to @recipe 
		else
			render new_recipe_path
		end

	
		
	end
end