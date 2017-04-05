Rails.application.routes.draw do
  get "/", to: "welcome#show"
  get "/Folio", to: "users#index", as: "folio"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  # admin
  namespace :admin do
    get '/dashboard', to: 'dashboard#index'
    resources :users, only: [:update, :show]
  end

  # password reset
  get '/password', to: 'passwords#new'
  post '/password', to: 'passwords#create'
  get '/password/update', to: 'passwords#edit', as: "reset_password"
  put '/password/update', to: 'passwords#update', as: "update_password"

  # users
  resources :users, path: '', only: [:show, :edit, :update]
  resources :users, only: [:new, :create]

  # folders
  resources :folders, path: "f/:id", only: [:new, :create]
  resources :folders, path: :f, only: [:show, :update] do
    get "/share", to: "folders/collaborations#new"
    post "/share", to: "folders/collaborations#create"
    get "/share/:id", to: "folders/collaborations#show", as: "shared"
  end

  get "/f/:id/download", to: "folders/download#index", as: "folder_download"

  # uploads, comments & download
  resources :uploads, path: :u, only: [:new, :create, :show, :update, :destroy]
  get "/u/:id/download", to: "uploads/download#index", as: "upload_download"
  resources :uploads, path: :u, only: [:show] do
    resources :comments, only: [:create]
  end

  # public folders and files
  get '/public', to: "public#index"
  namespace :public do
    resources :folders, path: :f, only: [:show]
    resources :uploads, path: :u, only: [:show]
  end
end
