class UserEvent < ApplicationRecord
  # == Relations =========================
  belongs_to :user
  belongs_to :market
  # == Enums =============================
  enum status: {
    going: 0
  }
end
