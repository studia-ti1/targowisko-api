# frozen_string_literal: true

class MarketRatingsController < ApplicationController
  # POST /api/v1/markets/:market_id/rate
  def create
    market = Market.find(params[:market_id])
    market_rating = market.market_ratings.create!(ratings_params.merge(user_id: @user.id))
    # send email
    RatingsNotificationMailer.with(market_id: params[:market_id], market_rating_id: market_rating.id).new_rating_email.deliver_now
    render json: market_rating
  end

  private

  def ratings_params
    params.permit(:rating, :comment)
  end
end
