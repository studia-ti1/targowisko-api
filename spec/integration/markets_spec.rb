# spec/integration/markets_spec.rb
require 'swagger_helper'

describe 'Markets API' do

    path '/api/v1/markets' do

      get 'Get saved Markets' do
        tags 'Markets'
        parameter name: 'access-token', :in => :header, schema:[ type: :string ]

        response '200', 'Saved Markets found' do
          run_test!
        end

        response '401', 'Unauthorized' do
          run_test!
        end
      end
    end
end