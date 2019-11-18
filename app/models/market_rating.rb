# frozen_string_literal: true

class MarketRating < ApplicationRecord
  belongs_to :market
  belongs_to :user

  # == Callbacks ===================
  after_commit :update_market_rating

  def update_market_rating
    new_rating = market.market_ratings.average(:rating).round(1, half: :up)
    market.update(average_rating: new_rating)
  end
end
