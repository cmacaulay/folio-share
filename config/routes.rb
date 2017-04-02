Rails.application.routes.draw do
  namespace :uploads do
    get 'download/index'
  end

  namespace :folders do
    get 'download/index'
  end

  namespace :uploads do
    get 'download/create'
  end

  namespace :folders do
    get 'download/create'
  end

  get "/", to: "welcome#show"
  get "/home", to: "users#show"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

#password reset
  get '/password', to: 'passwords#new'
  post '/password', to: 'passwords#create'
  get '/password/update', to: 'passwords#edit', as: "reset_password"
  put '/password/update', to: 'passwords#update', as: "update_password"

  resources :users, only: [:new, :create, :edit, :update]
  resources :folders, path: :f, only: [:show]
  resources :folders, path: "f/:id", only: [:new, :create]
  get "/f/:id/download", to: "folders/download#index", as: "folder_download"
  resources :uploads, path: :u, only: [:show, :new, :create]
  get "/u/:id/download", to: "uploads/download#index", as: "upload_download"
end
