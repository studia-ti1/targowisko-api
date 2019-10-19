# frozen_string_literal: true

class User < ApplicationRecord
  has_many :products
  has_many :markets
  has_many :market_ratings
  has_many :product_ratings
end
