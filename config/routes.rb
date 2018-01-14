Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'home#index'
	resources :recipes, only: [:show, :new, :create, :edit, :update, :destroy] do
		collection do 
			get 'search'
		end
	end
	resources :cuisines, only: [:show, :new, :create]
	resources :recipe_types, only:[:show,:new, :create]
end

# authenticate :user do
#     resources :recipes, only: [:new, :create, :edit, :update, :destroy]
#   end
  
#   resources :recipes, only: [:show] do
#     collection do 
#       get 'search'
#     end
#   end