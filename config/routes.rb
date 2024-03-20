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
    resources :sources, only: %i[index] do
      collection do
        get :chosen
        post :update
        get :edit
      end
    end
    resources :accounts do
      resources :transactions, except: %i[show]
      member do
        get :import, action: 'import'
        post :upload_data, action: 'upload_data'
      end
    end
    resources :planned_transactions, except: %i[show]
    put '/update_checked', to: 'transactions#update_checked'
    resources :categories, only: %i[index new create destroy]
    get '/:url_shortened', to: 'short_urls#url_shortened'
  end
end
