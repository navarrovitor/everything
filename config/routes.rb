Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }

  authenticated :user do
    root 'battles#showmovies', as: :authenticated_root
  end

  resources :movies
  resources :profiles
  resources :users, only: [:index, :show]
  resources :points, only: [:index, :show]


  # resources :points
  patch 'point', to: 'points#update', as: 'updatepoints'
  patch 'seenalready', to: 'points#seen_already', as: 'seenalready'

  get 'battles', to: 'battles#battlepage', as: 'battlepage'
  get 'playershow', to: 'battles#showmovies', as: 'playershow'
  get 'apitest', to: 'battles#apitest', as: 'apitest'
  get 'recommendations', to: 'battles#recommendations', as: 'recommend'

  # get 'landing', to: 'battles#landing', as: 'landing_page'
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
