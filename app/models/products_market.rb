# frozen_string_literal: true

class ProductsMarket < ApplicationRecord
  # == Relations ===================
  belongs_to :product
  belongs_to :market
end
