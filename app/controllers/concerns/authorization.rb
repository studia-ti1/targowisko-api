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
      @profile = @profile.get_object('me', fields: %w[email first_name last_name events picture])
      if User.where(email: @profile['email']).blank?
        created_user = User.create!(email: @profile['email'], first_name: @profile['first_name'], last_name: @profile['last_name'])
        created_user.remote_avatar_url = @profile.dig('picture', 'data', 'url')
        created_user.save!
      end
      @user = User.find_by(email: @profile['email'])
    end
  end
end
