Rails.application.routes.draw do
  devise_for :users
  resources :movies
  resources :points
  
  root to: 'pages#componentstest'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
