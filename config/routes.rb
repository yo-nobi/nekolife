Rails.application.routes.draw do
  root to: 'toppages#index'
  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'mycats', to: 'cats#index_my'
  get 'yourcats', to: 'cats#index_your'
  
  get 'food', to: 'microposts#index_food'
  get 'play', to: 'microposts#index_play'
  get 'live', to: 'microposts#index_live'
  
  get 'signup', to: 'users#new'
  
  resources :users, only: [:index, :show, :new, :create]
  resources :cats, only: [:show, :new, :create, :edit, :update, :destroy]
  resources :microposts, only: [:show, :create, :destroy]
  resources :comments, only: [:create, :destroy]
end
