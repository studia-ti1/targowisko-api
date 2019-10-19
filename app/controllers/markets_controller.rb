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

  def fetch_from_api
    @profile.dig('events', 'data').each { |event| create_market_if_needed(event) }

    render json: { status: 'success' }, status: :created
  end

  private

  def create_market_if_needed(event)
    return if Market.where(facebook_event_id: event['id']).present?

    Market.create!(name: event['name'], description: event['description'],
                   facebook_event_id: event['id'], location: event['place'], user: @user)
  end
end
