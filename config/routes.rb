Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :events, only: [ :index, :show, :create, :update, :destroy ] do
        resources :appointments, only: [:new, :create]
      end
      resources :appointments, only: [:index, :update, :destroy] do
        resources :reviews, only: [:new, :create]
      end
      resources :users, only: [:show]
    end
    end
  end
