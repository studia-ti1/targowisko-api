# frozen_string_literal: true

require 'open-uri'

class MarketFetchWorker
  include Sidekiq::Worker

  def perform(ids, access_token, user_id)
    graph = Koala::Facebook::API.new(access_token)
    ids.reject! { |id| Market.find_by(facebook_event_id: id) }

    ids.each do |id|
      event = graph.get_object(id, fields: %w[name description id place cover start_time end_time])
      market = Market.create!(name: event['name'], description: event['description'],
                              facebook_event_id: event['id'], place: event['place'], user_id: user_id,
                              starts_at: event['start_time'], ends_at: event['end_time'])
      market.remote_image_url = event.dig('cover', 'source')
      market.save!
    end
  end
end
