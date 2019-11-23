# frozen_string_literal: true

class ProductRatingsController < ApplicationController

  # POST /api/v1/products/:product_id/rate
  def create
    product = Product.find(params[:product_id])
    render json: product.product_ratings.create!(ratings_params.merge(user_id: @user.id))
  end

  private

  def ratings_params
    params.permit(:rating, :comment)
  end
end
