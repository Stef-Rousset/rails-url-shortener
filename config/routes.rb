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
  scope '(:locale)', locale: /fr|en/ do # parentheses means that the use of locals is optional
    root 'pages#home'
    get '/about', to: 'pages#about'
    get '/weather', to: 'pages#weather'
    get '/spell_checker', to: 'pages#spell_checker'
    post '/spell_checked', to: 'pages#spell_checked'
    resources :short_urls, only: %i[index show new create destroy]
    resources :sources, only: %i[index]
    get '/choose_sources', to: 'sources#choose_sources'
    post '/update_sources_for_user', to: 'sources#update_sources_for_user'
    get '/edit_sources_for_user', to: 'sources#edit_sources_for_user'
    resources :accounts do
      resources :transactions, except: %i[show]
    end
    resources :planned_transactions, except: %i[show]
    put '/update_checked', to: 'transactions#update_checked'
    resources :categories, only: %i[index new create destroy]
    get '/:url_shortened', to: 'short_urls#url_shortened'
  end
end
