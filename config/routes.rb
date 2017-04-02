Rails.application.routes.draw do
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
  # resources :folders, path: :f, only: [:show, :new, :create]
  resources :uploads, path: :u, only: [:new, :create, :destroy]
  resources :uploads, path: :u, only: [:show] do
    resources :comments, only: [:create]
  end
end
