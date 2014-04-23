JkPlatform::Application.routes.draw do
  resources :roles

  resources :users

  resources :menus

  resources :agencies

  root 'agencies#index'
end
