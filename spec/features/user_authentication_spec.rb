require 'rails_helper'

feature 'User authentication' do 
  scenario 'login' do
    user = User.create(email: 'dell@marques.com.br', password: '123456')

    visit root_path
    click_on 'Entrar'

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'

    expect(page).to have_content("Bem-vindo #{user.email}")
    expect(page).not_to have_css('a', text: 'Entrar')
  end
  scenario 'logout' do
    user = User.create(email: 'dell@marques.com.br', password: '123456')

    visit root_path
    click_on 'Entrar'

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'
    click_on 'Sair'

    expect(page).to have_css('a', text: 'Entrar')
    expect(page).not_to have_content("Bem-vindo #{user.email}")
  end
end