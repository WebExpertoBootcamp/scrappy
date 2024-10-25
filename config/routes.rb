Rails.application.routes.draw do
=begin
  devise_for :users
=end
  devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    sign_up: 'register'
  }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get "landing/index"
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  get '/health', to: 'health#health'

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  # root "posts#index"
  resources :users
  resources :categories
  resources :products
  resources :product_histories
  resources :links
  root 'landing#index'

   # Rutas para la API
   namespace :api do
    namespace :v1 do
      post 'auth/register', to: 'api_user#register'
      post 'auth/login', to: 'api_user#login'
    end
  end
end
