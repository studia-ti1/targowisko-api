# spec/integration/markets_spec.rb
require 'swagger_helper'

describe 'Markets API' do

    path '/api/v1/markets' do

      get 'Get saved Markets' do
        tags 'Markets'
        parameter name: 'access-token', :in => :header, schema:[ type: :string ]
        parameter name: :filer, in: :body, schema: {
            type: :object,
            properties: {
                user_id: {type: :integer},
                search_value: {type: :string},
                product_id: {type: :integer}
            },
        }
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

      delete 'Delete Market' do
        tags 'Markets'
        parameter name: :id, :in => :path, schema:[ type: :string]
        parameter name: 'access-token', :in => :header, schema:[ type: :string ]


        response '200', 'Destroy the Market' do
          #let(:id) do
          #   {
          #       success: true
          #   }
          #end
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
        parameter name: 'access-token', :in => :header, schema:[ type: :string ]
        parameter name: :event, in: :body, schema: {
            type: :object,
            properties: {
                facebook_events_ids: { type: :array, items: {type: :integer} }
            },
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

    path '/api/v1/top_markets' do

      get 'Get top rated Markets' do
        tags 'Markets'
        consumes 'application/json'
        parameter name: 'access-token', :in => :header, schema:[ type: :string ]
        parameter name: :count, in: :body, schema: {
            type: :object,
            properties: {
                count: { type: :integer }
            }
        }

        response '200', 'Top Markets' do
          run_test!
        end

        response '401', 'Unauthorized' do
          run_test!
        end
      end
    end

    path '/api/v1/markets/{id}/add_product' do

      post 'Add product to the Market' do
        tags 'Markets'
        parameter name: :id, :in => :path, schema:[ type: :string]
        parameter name: 'access-token', :in => :header, schema:[ type: :string ]
        parameter name: :product_id, in: :body, schema: {
            type: :object,
            properties: {
                product_id: { type: :integer }
            }
        }

        response '200', 'Product added to the Market' do
          run_test!
        end

        response '401', 'Unauthorized' do
          run_test!
        end
      end
    end

    path '/api/v1/markets/{id}/remove_product' do

      delete 'Remove product from the Market' do
        tags 'Markets'
        parameter name: :id, :in => :path, schema:[ type: :string]
        parameter name: 'access-token', :in => :header, schema:[ type: :string ]
        parameter name: :product_id, in: :body, schema: {
            type: :object,
            properties: {
                product_id: { type: :integer }
            }
        }

        response '200', 'Product deleted from the Market' do
          run_test!
        end

        response '401', 'Unauthorized' do
          run_test!
        end
      end
    end
end