# frozen_string_literal: true

class MarketRatingsController < ApplicationController
  def create
    market = Market.find(params[:market_id])
    render json: market.market_ratings.create!(ratings_params.merge(user_id: @user.id))
  end

  private

  def ratings_params
    params.permit(:rating, :comment)
  end
end
