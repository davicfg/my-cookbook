class RecipesController < ApplicationController
	# before_action :set_recipe, only: [:show, :edit, :update]
	def show
		@recipe = Recipe.find(params[:id])
	end
	def new
		# @recipe_types = RecipeType.all
		@recipe = Recipe.new 
		# @cuisines = Cuisine.all
	end

	def create
		recipe_params = params.require(:recipe).permit(:title, 
			:recipe_type_id, :cuisine_id, :difficulty, 
			:cook_time, :ingredients, :method )
		@recipe = Recipe.new(recipe_params)

		if @recipe.valid?
			@recipe.save
			redirect_to @recipe 
		else
			render new_recipe_path
		end		
	end

	def edit
		@recipe = Recipe.find(params[:id])
		@recipe_types = RecipeType.all
		@cuisines = Cuisine.all

	end

	def update
		@recipe = Recipe.find(params[:id])
		if @recipe.update(recipe_params())
			redirect_to @recipe
		else
			@recipe_types = RecipeType.all
			@cuisines = Cuisine.all
      render 'edit'
		end
	end

	def search
		@recipes = Recipe.where("title LIKE :keyword or ingredients LIKE :keyword",keyword: "%#{params[:query]}%")
		
    flash.now[:notice] = 'Nenhuma receita encontrada' if @recipes.empty?
	end

  private

  def recipe_params
    params.require(:recipe).permit(:title, :recipe_type_id, :difficulty, :cuisine_id, :cook_time, :ingredients, :method)
  end
end