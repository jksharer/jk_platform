JkPlatform::Application.routes.draw do
  resources :agencies

  root 'agencies#index'
end
