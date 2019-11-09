# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Authorization
  include ExceptionsHandlers
  protect_from_forgery prepend: true
  skip_before_action :verify_authenticity_token
  before_action :authenticate_facebook_user
end
