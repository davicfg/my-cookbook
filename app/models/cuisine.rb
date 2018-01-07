class Cuisine < ApplicationRecord
	validates :name, presence: { message: "Você deve informar o nome da cozinha" }
end
