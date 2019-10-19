# frozen_string_literal: true

class Market < ApplicationRecord
  belongs_to :user
  has_many :products_markets
  has_many :products, through: :products_markets
  has_many :market_ratings
end
