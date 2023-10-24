Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root 'pages#home'
  get '/about', to: 'pages#about'
  resources :short_urls, only: %i[index show new create]
  resources :sources, only: %i[index]
  get '/choose_sources', to: 'sources#choose_sources'
  post '/add_sources_to_user', to: 'sources#add_sources_to_user'
  get '/:url_shortened', to: 'short_urls#url_shortened'
end
