class ProductsMarket < ApplicationRecord
  belongs_to :product
  belongs_to :market
end
