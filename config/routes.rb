Rails.application.routes.draw do
  scope '/api/v1' do
    get 'markets/index', to: 'markets#index'
    post 'markets/fetch_from_api', to: 'markets#fetch_from_api'
  end
end
