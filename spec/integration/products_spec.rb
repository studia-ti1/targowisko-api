# spec/integration/markets_spec.rb
require 'swagger_helper'

describe 'Products API' do

  path '/api/v1/products' do

    get 'Get all Products' do
      tags 'Products'
      parameter name: 'access-token', :in => :header, schema:[ type: :string ]

      response '200', 'Products found' do
        run_test!
      end

      response '401', 'Unauthorized' do
        run_test!
      end
    end

    post 'Create new Product' do
      tags 'Products'
      consumes 'application/json'
      parameter name: 'access-token', :in => :header, schema:[ type: :string ]
      parameter name: :product, in: :body, schema: {
          type: :object,
          properties: {
              name: { type: :string },
              price: { type: :integer },
              category: { type: :string }
          },
      }

      response '200', 'Product created' do
        run_test!
      end

      response '401', 'Unauthorized' do
        run_test!
      end
    end
  end

  path '/api/v1/products/{id}' do

    get 'Get one Product with :id' do
      tags 'Products'
      parameter name: :id, :in => :path, schema:[ type: :string]
      parameter name: 'access-token', :in => :header, schema:[ type: :string]

      response '200', 'The Product with :id found' do
        run_test!
      end

      response '401', 'Unauthorized' do
        run_test!
      end
    end

    patch 'Update Product info' do
      tags 'Products'
      consumes 'application/json'
      parameter name: :id, :in => :path, schema:[ type: :string]
      parameter name: 'access-token', :in => :header, schema:[ type: :string]
      parameter name: :product, in: :body, schema: {
          type: :object,
          properties: {
              name: { type: :string },
              price: { type: :integer },
          }
      }
      produces 'application/json'

      response '200', 'Updated Product info' do
        run_test!
      end

      response '401', 'Unauthorized' do
        run_test!
      end
    end

    delete 'Delete Product' do
      tags 'Products'
      parameter name: :id, :in => :path, schema:[ type: :string]
      parameter name: 'access-token', :in => :header, schema:[ type: :string ]


      response '200', 'The Product deleted' do
        #let(:id) do
        #   {
        #       status: {type: :string}
        #   }
        #end
        run_test!
      end

      response '401', 'Unauthorized' do
        run_test!
      end
    end

  end

  path '/api/v1/top_products' do

    get 'Get top rated Products' do
      tags 'Products'
      consumes 'application/json'
      parameter name: 'access-token', :in => :header, schema:[ type: :string ]
      parameter name: :count, in: :body, schema: {
          type: :object,
          properties: {
              count: { type: :integer }
          }
      }

      response '200', 'Top Products' do
        run_test!
      end

      response '401', 'Unauthorized' do
        run_test!
      end
    end
  end
end