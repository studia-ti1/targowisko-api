# frozen_string_literal: true

class Market < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :user
  has_many :products_markets, dependent: :destroy
  has_many :products, through: :products_markets
  has_many :market_ratings
end
