Rails.application.routes.draw do
  get 'profiles/new'
  get 'profiles/create'
  get 'profiles/show'
  get 'profiles/edit'
  get 'profiles/update'
  get 'profiles/destroy'
  get 'new/create'
  get 'new/show'
  get 'new/edit'
  get 'new/update'
  get 'new/destroy'
  devise_for :users

  resources :movies
  resources :profiles, except:[:index]

  # resources :points
  patch 'point', to: 'points#update', as: 'updatepoints'

  get 'battles', to: 'battles#battlepage', as: 'battlepage'
  get 'playershow', to: 'battles#showmovies', as: 'playershow'
  get 'apitest', to: 'battles#apitest', as: 'apitest'

  # get 'landing', to: 'battles#landing', as: 'landing_page'
  root to: 'pages#componentstest'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
