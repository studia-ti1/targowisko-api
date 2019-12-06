# frozen_string_literal: true

class MarketsController < ApplicationController
  include Pagy::Backend
  DEFAULT_NUMBER_OF_TOP_MARKETS = 5
  before_action :set_market, only: %i[show update add_product remove_product attend]

  # GET /api/v1/markets
  def index
    markets = Market.all.by_user(params[:user_id]).by_name(params[:search_value]).by_product(params[:product_id])
    markets = if !markets.empty?
                _, paginated_collection = pagy(markets, items: params[:items] || markets.count, page: params[:page] || 1)
                paginated_collection
              else
                []
              end

    render json: markets
  end

  # GET api/v1/top_markets
  def top_markets
    top_markets_avg_ids = MarketRating.group(:market_id).average(:rating).sort { |a, b| b[1] <=> a[1] }.first(params[:count].to_i || DEFAULT_NUMBER_OF_TOP_MARKETS)
    top_markets_ids = top_markets_avg_ids.map(&:first)
    markets = Market.where(id: top_markets_ids)

    render json: markets
  end

  def attending_markets
    attending_markets_ids = @user.user_events.pluck(:market_id)
    markets = Market.where(id: attending_markets_ids)
    render json: markets
  end

  # GET /api/v1/markets/:id
  def show
    render json: JSON.parse(@market.to_json).merge!(going: @user.user_events.pluck(:market_id).include?(@market.id))
  end

  # POST /api/v1/create_markets
  def create_markets
    MarketFetchWorker.perform_async(market_params[:facebook_events_ids], request.headers['HTTP_ACCESS_TOKEN'], @user.id)
    render json: { success: true }
  end

  # PATCH/PUT /api/v1/markets/:id
  def update
    @market.update(market_params)
    render json: @market
  end

  # DELETE /api/v1/markets/:id
  def destroy
    @user.markets.destroy(params[:id])
    render json: { success: true }
  end

  # POST /api/v1/markets/fetch_from_api
  def fetch_from_api
    events = []
    events_from_profile = @profile.dig('events', 'data')
    return render json: {} unless events_from_profile
    access_token = request.headers['HTTP_ACCESS_TOKEN']
    graph = Koala::Facebook::API.new(access_token)

    events_from_profile.each do |event|
      photo = graph.get_object(event['id'], fields: %w[cover]).dig('cover', 'source')
      events << event.extract!('name', 'description', 'id', 'place', 'start_time', 'end_time').merge(photo: photo)
    end
    render json: events
  end

  # POST /api/v1/markets/:id/add_product
  def add_product
    market_products = @market.products
    market_products << @user.products.find(params[:product_id])
    render json: @market
  end

  # DELETE /api/v1/markets/:id/remove_product
  def remove_product
    market_products = @market.products
    user_product = @user.products.find(params[:product_id])
    market_products.destroy(user_product)

    render json: @market
  end

  def attend
    render json: @market.participants.create!(user_id: @user.id)
  end

  private

  def set_market
    @market = Market.find(params[:id])
  end

  def market_params
    params.permit(:name, :description, :category, :avatar, :place, :category, facebook_events_ids: [])
  end
end
