Rails.application.routes.draw do

  get 'points/index'
  get 'points/show'
  get 'points/new'
  get 'points/create'
  get 'points/edit'
  get 'points/update'
  get 'points/destroy'
  devise_for :users

  resources :movies

  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
