Rails.application.routes.draw do
  get "/", to: "welcome#show"

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  resources :folders, path: :f, only: [:show, :new, :create]
  resources :uploads, path: :u, only: [:show, :new, :create]

  resources :users, only: [:new, :create, :update]
  get "/home", to: "users#index"
  get "/:username", to: "users#show", as: "account_details"
  get "/:username/edit", to: "users#edit", as: "edit_user"
end
