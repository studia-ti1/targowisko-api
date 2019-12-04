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

  path '/api/v1/users/{id}' do

    get 'Get specified user' do
      tags 'Users'
      parameter name: :id, :in => :path, schema:[ type: :string]
      parameter name: 'access-token', :in => :header, schema:[ type: :string]

      response '200', 'User with id found' do
        run_test!
      end

      response '401', 'Unauthorized' do
        run_test!
      end
    end

  end

  path '/api/v1/top_users' do

    get 'Get top rated users with at least one product' do
      tags 'Users'
      parameter name: 'access-token', :in => :header, schema:[ type: :string ]
      parameter name: :count, in: :body, schema: {
          type: :object,
          properties: {
              count: { type: :integer }
          }
      }
      produces 'application/json'

      response '200', 'Top Users found' do
        run_test!
      end

      response '401', 'Unauthorized' do
        run_test!
      end
    end


  end

  path '/api/v1/users/update_avatar' do

    post 'Upload user avatar' do
      tags 'Users'
      consumes 'multipart/form-data'
      parameter name: 'access-token', :in => :header, schema:[ type: :string ]
      parameter name: :avatar, :in => :formData, schema: {
          type: :file,
          format: :binary
      }
      produces 'application/json'


      response '200', 'Avatar Uploaded' do
        run_test!
      end

      response '401', 'Unauthorized' do
        run_test!
      end
    end

  end

end