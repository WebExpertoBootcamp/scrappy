Rails.application.routes.draw do
  require 'sidekiq/web'
  require 'sidekiq/cron/web'
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
  mount ActionCable.server => '/cable' # Ruta para WebSocket
  mount Sidekiq::Web => "/sidekiq" # mount Sidekiq::Web in your Rails app

  devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    sign_up: 'register'
  }, controllers: {
    invitations: 'devise/invitations' # Agregas el controlador para manejar las invitaciones
  }

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  get "landing/index"
  get "up" => "rails/health#show", as: :rails_health_check
  get '/health', to: 'health#health'

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
      put 'auth/subscription', to: 'api_user#subscription'
      delete 'auth/subscription', to: 'api_user#unsubscription'
      get 'auth/mysubscriptions', to: 'api_user#mysubscriptions'
      get 'auth/list_categories', to: 'api_user#list_categories'
    end
   end
end
