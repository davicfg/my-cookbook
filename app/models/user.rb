class User < ApplicationRecord
  has_many :recipes
  has_many :favorites
  has_many :favorite_recipes, through: :favorites, source: :recipe
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable  

  def favorited?(recipe)
    favorite_recipes.include?(recipe)
  end
end
