# frozen_string_literal: true

class ProductRating < ApplicationRecord
  # == Relations ===================
  belongs_to :product
  belongs_to :user
  # == Validations =================
  validates :rating, inclusion: { in: 1..5, message: 'The rating must be within 1 and 5' }
end
