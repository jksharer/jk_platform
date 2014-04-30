JkPlatform::Application.routes.draw do
  root 'main_pages#home'

  resources :departments
  resources :roles
  resources :users
  resources :menus
  resources :agencies
  resources :sessions, only: [:new, :create, :destroy]
  
  match '/login',  to: 'sessions#new',        via: 'get'
  match '/logout', to: 'sessions#destroy',    via: 'delete'
  match '/home',   to: 'main_pages#home',     via: 'get'
  match '/about',  to: 'main_pages#about',    via: 'get'
  match '/my',     to: 'main_pages#my',       via: 'get'

  match '/main_pages/home',   to: 'main_pages#home',            via: 'get'
  match '/change_password',   to: 'main_pages#change_password', via: 'get'
  match '/update_password',   to: 'main_pages#update_password', via: 'post'

end