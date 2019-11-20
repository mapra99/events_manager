Rails.application.routes.draw do
  resources :users, only: [:new, :create, :show]
  get '/signup', to: 'users#new'

  root "users#new"
end
