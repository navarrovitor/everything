Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }

  resources :movies
  resources :profiles


  # resources :points
  patch 'point', to: 'points#update', as: 'updatepoints'

  get 'battles', to: 'battles#battlepage', as: 'battlepage'
  get 'playershow', to: 'battles#showmovies', as: 'playershow'
  get 'apitest', to: 'battles#apitest', as: 'apitest'

  # get 'landing', to: 'battles#landing', as: 'landing_page'
  root to: 'pages#componentstest'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
