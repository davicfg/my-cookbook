require 'rails_helper'

feature 'User delete a recipe' do
	scenario 'successfully' do 
    user = create(:user)
    
		brazilian_cuisine = Cuisine.create(name: 'Brasileira')
		dessert_recipe_type = RecipeType.create(name: 'Sobremesa')

		recipe_to_delete = Recipe.create(title: 'Bolo de cenoura', recipe_type: dessert_recipe_type,
                          cuisine: brazilian_cuisine, difficulty: 'Médio',
                          cook_time: 50,
                          ingredients: 'Farinha, açucar, cenoura',
                          method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes', user: user)

		recipe_to_list = Recipe.create(title: 'Brigadeiro', recipe_type: dessert_recipe_type,
                          cuisine: brazilian_cuisine, difficulty: 'Fácil',
                          cook_time: 10,
                          ingredients: 'Chocolate, leite condensado e manteiga',
                          method: 'Misture tudo em uma panela e leve ao fogo', user: user)

    login_as(user, :scope => :user)
		visit root_path
		click_on recipe_to_delete.title
		click_on 'Excluir'

		expect(page).to have_css('h1', text: recipe_to_list.title)
		expect(page).to have_css('li', text: "#{recipe_to_list.cook_time} minutos")
		expect(page).not_to have_css('h1', text: recipe_to_delete.title)
		expect(page).not_to have_css('li', text: "#{recipe_to_delete.cook_time} minutos")
	end
end