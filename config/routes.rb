JkPlatform::Application.routes.draw do
  root 'agencies#index'

  resources :roles
  resources :users
  resources :menus
  resources :agencies
  resources :sessions, only: [:new, :create, :destroy]
  
  match '/login', to: 'sessions#new', via: 'get'
  match '/logout', to: 'sessions#destroy', via: 'delete'
end
