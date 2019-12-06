# frozen_string_literal: true

# spec/integration/markets_spec.rb
require 'swagger_helper'

describe 'Product Ratings API' do
  path '/api/v1/products/{id}/rate' do
    post 'Comment/rate Product' do
      tags 'Product Rating'
      parameter name: :id, in: :path, schema: [type: :string]
      parameter name: 'access-token', in: :header, schema: [type: :string]
      parameter name: :rating, in: :body, schema: {
        type: :object,
        properties: {
          rating: { type: :integer },
          comment: { type: :string }
        }
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
