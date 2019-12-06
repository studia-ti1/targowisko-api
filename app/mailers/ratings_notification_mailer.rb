# frozen_string_literal: true

class RatingsNotificationMailer < ApplicationMailer
  # market rating although the name may  be confusing
  def new_rating_email
    @market = Market.find(params[:market_id])
    @market_rating = MarketRating.find(params[:market_rating_id])

    mail(to: @market.user.email, subject: 'Twój market został oceniony!')
  end

  def new_product_rating
    @product = Product.find(params[:product_id])
    @product_rating = ProductRating.find(params[:product_rating_id])

    mail(to: @product.user.email, subject: 'Twój produkt został oceniony!')
  end
end
