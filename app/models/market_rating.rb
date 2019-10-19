# frozen_string_literal: true

class MarketRating < ApplicationRecord
  belongs_to :market
  belongs_to :user
end
