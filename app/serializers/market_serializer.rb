# frozen_string_literal: true

class MarketSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :facebook_event_id, :location, :owner, :image

  belongs_to :user
  has_many :products
  has_many :market_ratings

  def owner
    object.user
  end
end
