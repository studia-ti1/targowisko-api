# frozen_string_literal: true

class UserRatingsController < ApplicationController
  def create
    person_that_gets_rated = User.find(params[:user_id])
    render json: person_that_gets_rated.feedback.create!(ratings_params.merge(rater_id: @user.id))
  end

  private

  def ratings_params
    params.permit(:rating, :comment)
  end
end
