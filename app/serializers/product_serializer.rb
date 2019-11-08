# frozen_string_literal: true

class ProductSerializer < ActiveModel::Serializer
  attributes :id, :name, :price, :picture

  belongs_to :user
  has_many :markets
  has_many :product_ratings
end
