Rails.application.routes.draw do
  get "/", to: "welcome#show"
  get "/home", to: "users#index"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

#admin
  namespace :admin do
    get '/dashboard', to: 'dashboard#dashboard'
  end

#password reset
  get '/password', to: 'passwords#new'
  post '/password', to: 'passwords#create'
  get '/password/update', to: 'passwords#edit', as: "reset_password"
  put '/password/update', to: 'passwords#update', as: "update_password"

  resources :users, only: [:new, :create, :edit, :update, :show]
  resources :folders, path: :f, only: [:show]
  resources :folders, path: "f/:id", only: [:new, :create]
  # resources :folders, path: :f, only: [:show, :new, :create]
  resources :uploads, path: :u, only: [:show, :new, :create]
end
