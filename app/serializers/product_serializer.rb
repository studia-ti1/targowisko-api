# frozen_string_literal: true

class ProductSerializer < ActiveModel::Serializer
  attributes :id, :name, :price, :picture, :owner

  belongs_to :user
  has_many :markets
  has_many :product_ratings

  def owner
    object.user
  end
end
