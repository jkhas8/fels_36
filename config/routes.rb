Rails.application.routes.draw do
  get 'sessions/new'

  root 'static_pages#home'
  get 'help' => 'static_pages#help'
  get 'about' => 'static_pages#about'
  get 'contact' => 'static_pages#contact'
  get 'signup' => 'users#new'
  get 'login'   => 'sessions#new'
  post 'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'

  resources 'users' do
    member do
      get :following, :followers
    end
  end
  resources :relationships, only: [:create, :destroy]
  resources :categories, only: [:index]
  resources :words, only: [:index]
  namespace :admin do
    resources :categories, only: [:edit, :update, :destroy, :new, :create] do
      resources :words, only: [:new, :create, :destroy, :edit, :update]
    end
  end
  resources :categories do
    resources :lessions
  end
end
