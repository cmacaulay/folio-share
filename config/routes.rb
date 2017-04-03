Rails.application.routes.draw do
  get "/", to: "welcome#show"
  get "/home", to: "users#index"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  # admin
  namespace :admin do
    get '/dashboard', to: 'dashboard#dashboard'
  end

  # password reset
  get '/password', to: 'passwords#new'
  post '/password', to: 'passwords#create'
  get '/password/update', to: 'passwords#edit', as: "reset_password"
  put '/password/update', to: 'passwords#update', as: "update_password"

  # users
  resources :users, only: [:new, :create, :edit, :update, :show]

  # folders & download
  resources :folders, path: :f, only: [:show]
  resources :folders, path: "f/:id", only: [:new, :create]

  get "/f/:id/download", to: "folders/download#index", as: "folder_download"

  # uploads, comments & download
  resources :uploads, path: :u, only: [:new, :create, :show, :update, :destroy]
  get "/u/:id/download", to: "uploads/download#index", as: "upload_download"

  resources :uploads, path: :u, only: [:show] do
    resources :comments, only: [:create]
  end
end
