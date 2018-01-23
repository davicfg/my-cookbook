require 'rails_helper'

feature 'User can favorite a recipe' do
  scenario  'sucessfuly' do
    user = create(:user)
    recipe = create(:recipe, user: user)
    favorite = Favorite.create(user: user, recipe: recipe)

    login_as(user, :scope => :user)
    visit favorites_recipes_path

    expect(page).to have_link recipe.title
    expect(page).to have_content recipe.title
  end

  scenario 'favorite two recipes' do
    user = create(:user)
    
    recipe = create(:recipe, user: user)
    favorite = Favorite.create(user: user, recipe: recipe)
    recipe_two = create(:recipe, user: user, title: 'Torta de maça', cook_time: 300)
    favorite_two = Favorite.create(user: user, recipe: recipe_two)

    login_as(user, scope: :user)
    visit favorites_recipes_path

    expect(page).to have_link recipe.title
    expect(page).to have_content recipe.title
    expect(page).to have_link recipe_two.title
    expect(page).to have_content recipe_two.title
    expect(page).not_to have_link('Favoritar')
  end

  scenario 'mark a recipe as favorite' do
    user = create(:user)
    recipe = create(:recipe)

    login_as(user,scope: :user)

    visit root_path
    click_on recipe.title
    click_on 'Favoritar'  

    expect(page).to have_content('Receita favoritada com sucesso')
    expect(current_path).to eq recipe_path(recipe.id)
    expect(page).not_to have_link('Favoritar')
    expect(page).to have_link('Desfavoritar')
  end

  scenario 'unfavorite a recipe' do
     user = create(:user)
    recipe = create(:recipe, user: user)
    favorite = Favorite.create(user: user, recipe: recipe)

    login_as(user, :scope => :user)

    visit recipe_path(recipe)
    click_on 'Desfavoritar'

    expect(page).to have_content('Recipe desfavortiada com sucesso')
    expect(page).to have_link('Favoritar')
    expect(page).not_to have_link('Desfavoritar')
  end
end

  