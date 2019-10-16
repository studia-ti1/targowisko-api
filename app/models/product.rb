class Product < ApplicationRecord
  belongs_to :user
  has_many :products_markets
  has_many :markets, through: :products_markets
  has_many :product_ratings
end