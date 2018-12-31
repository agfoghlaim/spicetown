Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'registrations'
  }
 
  resources :products
  resources :categories
  resources :recipes
  #get 'home/index'
  root "products#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  match '/recipes/save_direction' => 'recipes#save_direction', :via => [:post], :as => 'save_direction'

  match '/recipes/remove_direction' => 'recipes#remove_direction', :via => [:post], :as => 'remove_direction'

  match '/recipes/edit_direction' => 'recipes#edit_direction', :via => [:post], :as => 'edit_direction'

  match '/recipes/save_anyingredient' => 'recipes#save_anyingredient', :via => [:post], :as => 'save_anyingredient'

  match '/recipes/remove_anyingredient' => 'recipes#remove_anyingredient', :via => [:post], :as => 'remove_anyingredient'

  match '/recipes/edit_anyingredient' => 'recipes#edit_anyingredient', :via => [:post], :as => 'edit_anyingredient'

end
