Rails.application.routes.draw do
  root "top#main"

  get "signup", to: "users#new"
  resources :users, only: [:create] do
    resource :profile, only: [:show, :edit, :update], controller: "profiles"
  end

  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"

  resources :tweets, only: [:create] do
    resource :like, only: [:create, :destroy]
  end
end
