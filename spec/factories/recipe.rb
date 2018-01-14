FactoryBot.define do
  factory :recipe do
    title 'Bolo'
    difficulty 'Fácil'
    cook_time 60
    ingredients 'Farinha e ovo'
    recipe_type 'Sobremesa'
    add_attribute(:method) {'Mistura e tudo e seja feliz'}
    cuisine
  end
end
