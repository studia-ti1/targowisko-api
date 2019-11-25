class UserRating < ApplicationRecord
  # == Relations ===================
  belongs_to :rater, class_name: 'User'
  belongs_to :user, class_name: 'User'
  # == Validations =================
  validates :rating, inclusion: { in: 1..5, message: 'The rating must be within 1 and 5' }

  after_commit :update_user_rating

  def update_user_rating
    new_rating = user.user_ratings.average(:rating).round(1, half: :up)
    user.update(average_rating: new_rating)
  end
end
