# frozen_string_literal: true

class MarketSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :facebook_event_id, :place, :owner, :image, :average_rating, :starts_at, :ends_at

  belongs_to :user
  has_many :products
  has_many :market_ratings

  def owner
    object.user
  end
end
