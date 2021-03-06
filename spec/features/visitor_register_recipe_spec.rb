require 'rails_helper'

feature 'Visitor register recipe' do
  scenario 'successfully' do
    #cria os dados necessários
    user = create(:user)

    Cuisine.create(name: 'Arabe')
    RecipeType.create(name: 'Entrada')
    RecipeType.create(name: 'Prato Principal')
    RecipeType.create(name: 'Sobremesa')
    user = User.create(email: 'dell@marques.com.br', password: '123456')
    # simula a ação do usuário
    login_as(user, :scope => :user)
    visit root_path
    click_on 'Enviar uma receita'

    fill_in 'Título', with: 'Tabule'
    select 'Arabe', from: 'Cozinha'
    select 'Entrada', from: 'Tipo da Receita'
    fill_in 'Dificuldade', with: 'Fácil'
    fill_in 'Tempo de Preparo', with: '45'
    fill_in 'Ingredientes', with: 'Trigo para quibe, cebola, tomate picado, azeite, salsinha'
    fill_in 'Como Preparar', with: 'Misturar tudo e servir. Adicione limão a gosto.'
    click_on 'Enviar'


    expect(page).to have_css('h1', text: 'Tabule')
    expect(page).to have_css('h3', text: 'Detalhes')
    expect(page).to have_css('p', text: 'Entrada')
    expect(page).to have_css('p', text: 'Arabe')
    expect(page).to have_css('p', text: 'Fácil')
    expect(page).to have_css('p', text: "45 minutos")
    expect(page).to have_css('h3', text: 'Ingredientes')
    expect(page).to have_css('p', text: 'Trigo para quibe, cebola, tomate picado, azeite, salsinha')
    expect(page).to have_css('h3', text: 'Como Preparar')
    expect(page).to have_css('p', text:  'Misturar tudo e servir. Adicione limão a gosto.')
  end

  scenario 'and must fill in all fields' do
    #cria os dados necessários, nesse caso não vamos criar dados no banco
    Cuisine.create(name: 'Arabe')
    user = User.create(email: 'dell@marques.com.br', password: '123456')
    # simula a ação do usuário
    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'
    click_on 'Enviar uma receita'

    fill_in 'Título', with: ''
    fill_in 'Dificuldade', with: ''
    fill_in 'Tempo de Preparo', with: ''
    fill_in 'Ingredientes', with: ''
    fill_in 'Como Preparar', with: ''
    click_on 'Enviar'


    expect(page).to have_content('Você deve informar todos os dados da receita')
  end
  scenario 'and must be logged in' do
    visit root_path

    expect(current_path).to eq(root_path)
    expect(page).not_to have_link('Enviar uma receita', href: new_recipe_path)
  end
  scenario 'and need to be logged in (try vi url)' do
    visit new_recipe_path

    expect(current_path).to eq(new_user_session_path)
    # expect(page).to have_content('Você não tem permissão para isso.')

  end
end