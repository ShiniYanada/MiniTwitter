Rails.application.routes.draw do

  get 'password_resets/new'
  get 'password_resets/edit'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/signup', to: 'users#new'
  delete '/delete', to: 'users#delete'

  resources :posts, only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]
  resources :favorites, only: [:create, :destroy]
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :users, param: :identifier do
    member do
      get :following, :followers, :favorites
    end
    collection do
      get :search
    end
  end


  root 'users#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
