Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root 'pages#home'
  get '/about', to: 'pages#about'
  get '/:url_shortened', to: 'short_urls#url_shortened'
  resources :short_urls, only: %i[index show new create]
end
