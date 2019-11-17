# frozen_string_literal: true

Rails.application.routes.draw do
  scope '/api/v1' do
    resources :markets do
      member do
        post :add_product
        delete :remove_product
      end
    end
    resources :products
    resources :user

    get '/top_markets', to: 'markets#top_markets'
    post 'markets/fetch_from_api', to: 'markets#fetch_from_api'
    post 'products/:product_id/rate', to: 'product_ratings#create'
    post 'create_markets', to: 'markets#create_markets'
  end
end
