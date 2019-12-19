# frozen_string_literal: true

class MarketRating < ApplicationRecord
  belongs_to :market
  belongs_to :user
  # == Validations =================
  validates :rating, inclusion: { in: 1..5, message: 'The rating must be within 1 and 5' }

  # == Callbacks ===================
  after_commit :update_market_rating

  def update_market_rating
    new_rating = market&.market_ratings&.average(:rating)&.round(1, half: :up)
    market&.update(average_rating: new_rating)
  end
end
