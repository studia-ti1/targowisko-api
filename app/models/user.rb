# frozen_string_literal: true

class User < ApplicationRecord
  mount_uploader :avatar, ImageUploader
  # == Relations =========================
  has_many :products, dependent: :destroy
  has_many :markets, dependent: :destroy
  has_many :market_ratings, dependent: :destroy
  has_many :product_ratings, dependent: :destroy
  has_many :feedback, class_name: 'UserRating', foreign_key: 'user_id', dependent: :destroy
  has_many :ratings, class_name: 'UserRating', foreign_key: 'rater_id', dependent: :destroy
  has_many :user_events
  # == Scopes ============================
  scope :by_first_name, ->(user_fname) { where('first_name LIKE ?', "%#{user_fname}%") unless user_fname.nil? }
  scope :by_last_name, ->(user_lname) { where('last_name LIKE ?', "%#{user_lname}%") unless user_lname.nil? }
end
