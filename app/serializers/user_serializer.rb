# frozen_string_literal: true

class UserSerializer < ActiveModel::Serializer
  attributes :id, :last_name, :first_name, :email

  has_many :products
  has_many :markets
  has_many :market_ratings
  has_many :product_ratings
end
