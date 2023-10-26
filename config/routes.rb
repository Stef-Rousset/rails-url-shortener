Rails.application.routes.draw do
  devise_for :users

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Sidekiq Web UI, only for admins.
  require 'sidekiq/web'
  require 'sidekiq-scheduler/web'
  authenticate :user, ->(user) { user.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  # Defines the root path route ("/")
  # root "articles#index"
  root 'pages#home'
  get '/about', to: 'pages#about'
  resources :short_urls, only: %i[index show new create]
  resources :sources, only: %i[index]
  get '/choose_sources', to: 'sources#choose_sources'
  post '/add_sources_to_user', to: 'sources#add_sources_to_user'
  get '/edit_sources_for_user', to: 'sources#edit_sources_for_user'
  get '/:url_shortened', to: 'short_urls#url_shortened'
end
