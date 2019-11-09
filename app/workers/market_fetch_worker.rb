# frozen_string_literal: true

class MarketFetchWorker
  include Sidekiq::Worker

  def perform(ids, access_token, user_id)
    graph = Koala::Facebook::API.new(access_token)
    ids.reject! { |id| Market.find_by(facebook_event_id: id) }

    ids.each do |id|
      event = graph.get_object(id)
      Market.create!(name: event['name'], description: event['description'],
        facebook_event_id: event['id'], location: event['place'], user_id: user_id)
    end
  end
end