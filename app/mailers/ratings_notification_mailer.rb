# frozen_string_literal: true

class RatingsNotificationMailer < ApplicationMailer
  default from: 'targowisko@dev.com'

  def new_rating_email
    @market = Market.find(params[:market_id])
    @market_rating = MarketRating.find(params[:market_rating_id])

    mail(to: @market.user.email, subject: 'Twój market został oceniony!')
  end
end
