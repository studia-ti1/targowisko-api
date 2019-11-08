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

    post 'markets/fetch_from_api', to: 'markets#fetch_from_api'
  end
end
