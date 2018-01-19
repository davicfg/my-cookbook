require 'rails_helper'

RSpec.describe RecipesMailer do
  describe 'share' do
    it 'should send the corret email' do
      recipe = create(:recipe)
      mail = RecipesMailer.share('c@gmail.com','msg', recipe.id)
      expect(mail.to).to include 'c@gmail.com'
      expect(mail.subject).to eq 'Compartilharam uma receita com você'
      expect(mail.from).to include 'no-reply@cookbook.com'
      expect(mail.body).to include 'ms'
      expect(mail.body).to include recipe_url(recipe)
    end

  end
end