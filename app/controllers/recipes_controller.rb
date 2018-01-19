class RecipesController < ApplicationController
	before_action :set_recipe, only: [:show, :edit, :update, :favorite, :unfavorite, :share]
  before_action :set_cuisines, only: [:new, :edit]
  before_action :authenticate_user!, only: [:create, :edit, :new]
	def show
		@recipe = Recipe.find(params[:id])
	end
	def new
		# @recipe_types = RecipeType.all
		@recipe = Recipe.new 
		# @cuisines = Cuisine.all
	end

	def create
    # if !user_signed_in?
    #   redirect_to root_path, notice: 'Você não tem permissão para isso.'      
    # end
  
		recipe_params = params.require(:recipe).permit(:title, 
			:recipe_type_id, :cuisine_id, :difficulty, 
			:cook_time, :ingredients, :method )
		@recipe = Recipe.new(recipe_params)
		@recipe.user = current_user
		if @recipe.valid?
			@recipe.save
			redirect_to @recipe 
		else
			render new_recipe_path
		end		
	end

	def edit
    if @recipe.user != current_user
        redirect_to recipe_path(@recipe), notice: 'Você não tem permissão para isso.'
    end
		@recipe = Recipe.find(params[:id])
		@recipe_types = RecipeType.all
		@cuisines = Cuisine.all

	end

	def update
		@recipe = Recipe.find(params[:id])
		@recipe.user = current_user
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
	def destroy
		@recipe = Recipe.find(params[:id])
		@recipe.destroy

		redirect_to root_path
	end

	def share 
		 email = params[:email]
		 msg = params[:mensagem]
		 RecipesMailer.share(email, msg,
                        @recipe.id).deliver_now

		flash[:success] = "Receita enviada para #{email} com sucesso"
    redirect_to @recipe

	end

  private

  def recipe_params
    params.require(:recipe).permit(:title, :recipe_type_id, :difficulty, :cuisine_id, :cook_time, :ingredients, :method)
  end

  def set_recipe
  	@recipe = Recipe.find(params[:id])
  end

  def set_cuisines
  	@cuisines = Cuisine.all
  end
end