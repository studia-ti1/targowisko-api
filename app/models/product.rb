# frozen_string_literal: true

class Product < ApplicationRecord
  mount_uploader :picture, ImageUploader
  # == Relations =========================
  belongs_to :user
  has_many :products_markets, dependent: :destroy
  has_many :markets, through: :products_markets
  has_many :product_ratings
  # == Validations =======================
  validates :price, presence: true
end
