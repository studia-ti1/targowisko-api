# spec/integration/markets_spec.rb
require 'swagger_helper'

describe 'User API' do

  path '/api/v1/users' do
    get 'Get all users with at least one product' do
      tags 'Users'
      parameter name: 'access-token', :in => :header, schema:[ type: :string ]
      parameter name: :rating, in: :body, schema: {
          type: :object,
          properties: {
              user_first_name: { type: :string },
              user_last_name: { type: :string }
          },
      }
      produces 'application/json'

      response '200', 'Users found' do
        run_test!
      end

      response '401', 'Unauthorized' do
        run_test!
      end
    end

  end

end