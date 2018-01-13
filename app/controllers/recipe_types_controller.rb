class RecipeTypesController < ApplicationController
	def show
		@recipe_type = RecipeType.find(params[:id])
		@recipes = Recipe.where('cuisine_id = ?' , @recipe_type)
	end

	def new 
		@recipe_type = RecipeType.new
	end
	def create 
		@recipe_type = RecipeType.new(params.require(:recipe_type).permit(:name))
		
		if @recipe_type.save
	      redirect_to @recipe_type
	    else
	      flash.now[:error] = 'Você deve informar o nome do tipo de receita'
	      render 'new'
    end

	end
end