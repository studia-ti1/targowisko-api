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
                unauthorized
            end
        end

        private

        def unauthorized
            render json: { errors: ['Not Authenticated'] }, status: :unauthorized
        end

        def create_user_if_needed
            @profile.get_object('me', fields: ['email', 'events'])
            User.create!(email: @profile['emai']) if !User.where(email: @profile['email']).present?
        end
    end
end
