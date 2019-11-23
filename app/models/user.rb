# frozen_string_literal: true

class User < ApplicationRecord
  # == Relations =========================
  has_many :products
  has_many :markets
  has_many :market_ratings
  has_many :product_ratings
  # == Scopes ============================
  scope :by_first_name, ->(user_fname) { where('first_name LIKE ?', "%#{user_fname}%") unless user_fname.nil? }
  scope :by_last_name, ->(user_lname) { where('last_name LIKE ?', "%#{user_lname}%") unless user_lname.nil? }
end
