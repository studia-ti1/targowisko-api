# frozen_string_literal: true

class MarketSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :facebook_event_id, :location

  belongs_to :user
  has_many :products
  has_many :market_ratings
end
