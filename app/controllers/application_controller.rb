class ApplicationController < ActionController::Base
    include Authorization
    before_action :authenticate_facebook_user
end
