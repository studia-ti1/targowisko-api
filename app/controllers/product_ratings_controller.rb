# frozen_string_literal: true

class ProductRatingsController < ApplicationController
  # POST /api/v1/products/:product_id/rate
  def create
    product = Product.find(params[:product_id])
    rating = product.product_ratings.create!(ratings_params.merge(user_id: @user.id))
    # send email
    RatingsNotificationMailer.with(product_id: params[:product_id], product_rating_id: rating.id).new_product_rating.deliver_now

    render json:
  end

  private

  def ratings_params
    params.permit(:rating, :comment)
  end
end
