Rails.application.routes.draw do
  root to: 'static_pages#home'
  get    'signup', to: 'users#new'
  get    'login' , to: 'sessions#new'
  post   'login' , to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  #get    'followed', to: 'users#followed'
  #get    'follower', to: 'users#follower'
  
  resources :users do
    member do 
      get 'followings','followers'
    end
  end
  resources :users do
    member do 
      get 'iine'
    end
  end
  resources :sessions, only: [:new, :create, :destroy]
  resources :microposts
  resources :relationships, only: [:create, :destroy]
  resources :like_relationships, only: [:create, :destroy]
  resources :micropostrelationships, only: [:create, :destroy]
end