# frozen_string_literal: true

module Authorization
  extend ActiveSupport::Concern

  included do
    def authenticate_facebook_user
      access_token = request.headers['HTTP_ACCESS_TOKEN']
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
      @profile = @profile.get_object('me', fields: %w[email first_name last_name events])
      User.create!(email: @profile['email'], first_name: @profile['first_name'], last_name: @profile['last_name']) unless User.where(email: @profile['email']).present?
      @user = User.find_by_email(@profile['email'])
    end
  end
end
