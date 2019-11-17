# frozen_string_literal: true

class MarketsController < ApplicationController
  include Pagy::Backend
  DEFAULT_NUMBER_OF_TOP_MARKETS = 5
  before_action :set_market, only: %i[show update]

  def index
    if Market.count != 0
      _, @markets = pagy(Market.all, items: params[:items] || Market.count, page: params[:page] || 1)
    else
      @markets = []
    end
    render json: @markets
  end

  def top_markets
    top_markets_avg_ids = MarketRating.group(:market_id).average(:rating).sort { |a, b| b[1] <=> a[1] }.first(params[:count].to_i || DEFAULT_NUMBER_OF_TOP_MARKETS)
    top_markets_ids = top_markets_avg_ids.map(&:first)
    markets = Market.where(id: top_markets_ids)

    render json: markets
  end

  def show
    render json: @market
  end

  def create_markets
    MarketFetchWorker.perform_async(market_params[:facebook_events_ids], request.headers['HTTP_ACCESS_TOKEN'], @user.id)
    render json: { success: true }
  end

  def update
    @market.update(market_params)
    render json: @market
  end

  def destroy
    @user.markets.destroy(params[:id])
    render json: { success: true }
  end

  def fetch_from_api
    events = []
    events_from_profile = @profile.dig('events', 'data')
    return render json: {} unless events_from_profile

    events_from_profile.each { |event| events << event.extract!('name', 'description', 'id', 'place') }

    render json: events
  end

  def add_product
    market_products = Market.find(params[:market_id]).products
    market_products << @user.products.find(params[:product_id])
    render json: market_products
  end

  def remove_product
    market_products = Market.find(params[:market_id]).products
    user_product = @user.products.find(params[:product_id])
    market_products.destroy(user_product)

    render json: market_products
  end

  private

  def set_market
    @market = Market.find(params[:id])
  end

  def market_params
    params.permit(:name, :description, :category, :avatar, :location, facebook_events_ids: [])
  end
end
