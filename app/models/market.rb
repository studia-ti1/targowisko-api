# frozen_string_literal: true

class Market < ApplicationRecord
  mount_uploader :image, ImageUploader
  # == Relations =========================
  belongs_to :user
  has_many :products_markets, dependent: :destroy
  has_many :products, through: :products_markets
  has_many :market_ratings
  # == Scopes ============================
  scope :by_user, ->(user_id) { where(user_id: user_id) unless user_id.nil? }
  scope :by_name, ->(market_name) { where('name LIKE ?', "%#{market_name}%") unless market_name.nil? }
  scope :by_product, ->(product_id) { joins(:products_markets).where(products_markets: { product_id: product_id }) unless product_id.nil? }
end
