# frozen_string_literal: true

class ProductsMarket < ApplicationRecord
  # == Relations ===================
  belongs_to :product
  belongs_to :market

  # == Validations =================
  validates :rating, inclusion: { in: 1..5, message: 'The rating must be within 1 and 5' }
end
