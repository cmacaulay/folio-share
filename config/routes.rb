Rails.application.routes.draw do
  get "/", to: "welcome#show"

  resources :users, only: [:new, :create, :edit, :update]

  get "/home", to: "users#show"

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  resources :users, only: [:new, :create, :edit, :update]

  resources :folders, path: :f, only: [:show, :new, :create]
  resources :uploads, path: :u, only: [:show, :new, :create]
end
