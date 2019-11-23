# frozen_string_literal: true

class Product < ApplicationRecord
  mount_uploader :picture, ImageUploader
  # == Relations =========================
  belongs_to :user, counter_cache: :products_count
  has_many :products_markets, dependent: :destroy
  has_many :markets, through: :products_markets
  has_many :product_ratings
  # == Validations =======================
  validates :price, presence: true
  validates :category, presence: true
  # == Scopes ============================
  scope :by_user, ->(user_id) { where(user_id: user_id) unless user_id.nil? }
  scope :by_category, ->(category) { where(category: category) if category }
  scope :by_name, ->(product_name) { where('name LIKE ?', "%#{product_name}%") unless product_name.nil? }
  scope :by_market, ->(market_id) { joins(:products_markets).where(products_markets: { market_id: market_id }) unless market_id.nil? }
  # == Enums =============================
  include CategoryEnum
end
