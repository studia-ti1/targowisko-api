# frozen_string_literal: true

module Authorization
  extend ActiveSupport::Concern

  included do
    def authenticate_facebook_user
      access_token = request.headers['access_token']
      begin
        graph = Koala::Facebook::API.new(access_token)
        @profile = graph
        create_user_if_needed
      rescue Koala::Facebook::AuthenticationError
        raise CustomExceptions::AuthenticationError
      end
    end

    private

    def create_user_if_needed
      @profile.get_object('me', fields: %w[email events])
      User.create!(email: @profile['emai']) unless User.where(email: @profile['email']).present?
    end
  end
end
