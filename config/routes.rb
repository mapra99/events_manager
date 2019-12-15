Rails.application.routes.draw do
  devise_for :users, controllers: { :omniauth_callbacks => "users/omniauth_callbacks" }
  
  resources :users, only: :show
  resources :events, only: [:index, :new, :create, :show]
  resources :attendings, only: :create

  root "events#index"
end
