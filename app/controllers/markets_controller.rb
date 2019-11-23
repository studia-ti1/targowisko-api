# frozen_string_literal: true

class MarketsController < ApplicationController
  include Pagy::Backend
  DEFAULT_NUMBER_OF_TOP_MARKETS = 5
  before_action :set_market, only: %i[show update add_product remove_product]

  def index
    markets = Market.all.by_user(params[:user_id]).by_name(params[:search_value]).by_product(params[:product_id])
    markets = if !products.empty?
                _, paginated_collection = pagy(markets, items: params[:items] || markets, page: params[:page] || 1)
                paginated_collection
              else
                []
              end
    render json: markets
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
    market_products = @market.products
    market_products << @user.products.find(params[:product_id])
    render json: @market
  end

  def remove_product
    market_products = @market.products
    user_product = @user.products.find(params[:product_id])
    market_products.destroy(user_product)

    render json: @market
  end

  private

  def set_market
    @market = Market.find(params[:id])
  end

  def market_params
    params.permit(:name, :description, :category, :avatar, :place, :category, facebook_events_ids: [])
  end
end
