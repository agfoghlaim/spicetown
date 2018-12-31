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
end
