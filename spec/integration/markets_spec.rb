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

    path '/api/v1/markets/{id}' do

      get 'Get one saved Market' do
        tags 'Markets'
        parameter name: :id, :in => :path, schema:[ type: :string]
        parameter name: 'access-token', :in => :header, schema:[ type: :string]

        response '200', 'Saved Market with id found' do
          run_test!
        end

        response '401', 'Unauthorized' do
          run_test!
        end
      end

      patch 'Update Market info' do
        tags 'Markets'
        consumes 'application/json'
        parameter name: :id, :in => :path, schema:[ type: :string]
        parameter name: 'access-token', :in => :header, schema:[ type: :string]
        parameter name: :market, in: :body, schema: {
          type: :object,
            properties: {
                name: { type: :string },
                description: { type: :string },
                place: {
                    type: :object,
                    properties: {
                        id: {type: :string},
                        name: {type: :string},
                        location: {
                            type: :object,
                            properties: {
                                zip: {type: :string},
                                city: {type: :string},
                                street: {type: :string},
                                country: {type: :string},
                                latitude: {type: :string},
                                longitude: {type: :string},
                            }
                        }
                    }
                }
            }
        }
        produces 'application/json'

        response '200', 'Updated Market info' do
          run_test!
        end

        response '401', 'Unauthorized' do
          run_test!
        end
      end

    end

    path '/api/v1/create_markets' do

      post 'Create new Market' do
        tags 'Markets'
        consumes 'application/json'
        parameter name: :id, :in => :path, schema:[ type: :string]
        parameter name: 'access-token', :in => :header, schema:[ type: :string ]
        parameter name: :event, in: :body, schema: {
            type: :object,
            properties: {
                facebook_events_ids: { type: :array, items: {type: :integer} }
            },
            required: [ 'name', 'status' ]
        }

        response '200', 'Created Market' do
          run_test!
        end

        response '401', 'Unauthorized' do
          run_test!
        end
      end
    end

    path '/api/v1/markets/fetch_from_api' do

      post 'Retrieve user facebook Events' do
        tags 'Markets'
        parameter name: 'access-token', :in => :header, schema:[ type: :string ]

        response '200', 'Facebook Events found' do
          run_test!
        end

        response '401', 'Unauthorized' do
          run_test!
        end
      end
    end

end