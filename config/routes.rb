Rails.application.routes.draw do
  devise_for :users
  
  resources :users, only: :show
  resources :events, only: [:index, :new, :create, :show]
  resources :attendings, only: :create

  root "events#index"
end
