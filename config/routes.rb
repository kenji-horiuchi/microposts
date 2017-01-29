Rails.application.routes.draw do
  resources :products
  root to: 'static_pages#home'
  get 'signup',  to: 'users#new'
  get    'login' , to: 'sessions#new'
  post   'login' , to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
 
  resources :users do
    member do
    get :followings, :followers, :favorites
    end 
  end
  
  resources :users, only: [:index, :show] do
    get :favorites, on: :member
  end
  
  resources :microposts,          only: [:create, :destroy]
  resources :microposts do
    # resources :favorite, only: [:create, :destroy]
    # post   microposts/:micropost_id/favorites favorites#create
    # delete microposts/:micropost_id/favorites/:id favorites#destroy
  end
  resources :relationships, only: [:create, :destroy]
  resources :favorites, only: [:create, :destroy]
  # post /favorites favorites#create
  # delete /favorites/:id favorites#destroy
end
