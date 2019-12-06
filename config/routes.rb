# frozen_string_literal: true

Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  scope '/api/v1' do
    resources :markets do
      member do
        post :add_product
        delete :remove_product
        post :attend
      end
    end
    resources :products
    resources :users

    delete '/users', to: 'users#destroy'
    get '/top_markets', to: 'markets#top_markets'
    get '/top_products', to: 'products#top_products'
    get '/attending_markets', to: 'markets#attending_markets'
    get '/top_users', to: 'users#top_users'
    get '/about_me', to: 'users#about_me'
    post 'markets/fetch_from_api', to: 'markets#fetch_from_api'
    post 'products/:product_id/rate', to: 'product_ratings#create'
    post 'markets/:market_id/rate', to: 'market_ratings#create'
    post 'users/:user_id/rate', to: 'user_ratings#create'
    post 'users/update_avatar', to: 'users#update_avatar'
    post 'create_markets', to: 'markets#create_markets'
    post '/users/api_update_avatar', to: 'users#api_update_avatar'
  end
end
