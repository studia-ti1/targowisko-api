# spec/integration/markets_spec.rb
require 'swagger_helper'

describe 'Market Ratings API' do

  path '/api/v1/markets/{id}/rate' do
    post 'Comment/rate Market' do
      tags 'Market Rating'
      parameter name: :id, :in => :path, schema:[ type: :string]
      parameter name: 'access-token', :in => :header, schema:[ type: :string ]
      parameter name: :rating, in: :body, schema: {
          type: :object,
          properties: {
              rating: { type: :integer },
              comment: { type: :string }
          },
      }
      produces 'application/json'

      response '200', 'Product created' do
        run_test!
      end

      response '401', 'Unauthorized' do
        run_test!
      end
    end

  end

end