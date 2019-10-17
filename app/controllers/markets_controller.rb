class MarketsController < ApplicationController
    def index
        # TODO: pagination
        @markets = Market.all
        render json: @markets
    end

    def fetch_from_api
        @graph.get_object('me', field: ['events'])
        @graph.dig('events', 'data').each { |event| create_market_if_needed(event) }

        render json: { status: 'success' }, status: :created
    end

    private

    def create_market_if_needed(event)
        return if Market.where(facebook_event_id: event['id']).present?

        # TODO: exceptions handlers
        Market.create!(name: event['name'], description: event['description'],
                        facebook_event_id: event['id'], location: event['location'])
    end
end
