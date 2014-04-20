JkPlatform::Application.routes.draw do
  resources :menus

  resources :agencies

  root 'agencies#index'
end
