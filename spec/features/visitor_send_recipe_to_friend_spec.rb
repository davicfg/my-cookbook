require 'rails_helper'

feature 'user send a recipe via email' do
  scenario 'successfully' do
    recipe = create(:recipe)
    friend_email = 'friend@friend.com'
    msg = 'olha que receita legal'
    visit root_path 
    click_on recipe.title
    fill_in 'Email', with: friend_email
    fill_in 'Mensagem', with: msg

    expect(RecipesMailer).to receive(:share).with(friend_email,msg,recipe.id ).and_call_original 

    click_on 'Enviar'

    expect(page).to  have_content("Receita enviada para friend@friend.com com sucesso")
    expect(current_path).to eq recipe_path(recipe)
  end
  scenario 'another successfully scenario' do
    recipe = create(:recipe, title: 'Feijoada de Frango')

    visit root_path
    click_on 'Feijoada de Frango'
    fill_in 'Email', with: 'amigo@email.com'
    fill_in 'Mensagem', with: 'Essa receita é muito legal'

    click_on 'Enviar'

    expect(page).to have_content 'Receita enviada para amigo@email.com'
    expect(current_path).to eq recipe_path(recipe)
    mail = ActionMailer::Base.deliveries.last
    expect(mail.to).to include 'amigo@email.com'
    expect(mail.subject).to eq 'Compartilharam uma receita com você'
    expect(mail.body).to include 'Essa receita é muito legal'
    expect(mail.body).to include recipe_url(recipe, host: 'localhost:3000')

  end
end