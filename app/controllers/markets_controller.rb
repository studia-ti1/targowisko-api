# frozen_string_literal: true

class MarketsController < ApplicationController
  include Pagy::Backend

  def index
    @markets = if Market.count != 0
                 _, paginated_collection = pagy(Market.all, items: params[:items] || Market.count, page: params[:page] || 1)
                 paginated_collection
               else
                 []
            end

    render json: @markets
  end

  def show
    render json: Market.find(params[:id])
  end

  def create
    render json: create_market_if_needed
  end

  def update
    market = Market.find(params[:id])
    market.update(market_params)
    render json: market
  end

  def destroy
    @user.markets.destroy(params[:id])

    render json: { status: 'deleted' }
  end

  def fetch_from_api
    events = []
    @profile.dig('events', 'data').each { |event| events << event.extract!('name', 'description', 'id', 'place') }

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

  def market_params
    params.permit(:name, :description, :category, :avatar, :location)
  end

  def create_market_if_needed
    return if Market.where(facebook_event_id: params['id']).present?

    Market.create!(name: params['name'], description: params['description'],
                   facebook_event_id: params['id'], location: params['place'], user: @user)
  end
end