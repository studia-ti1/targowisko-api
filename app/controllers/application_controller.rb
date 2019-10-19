# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Authorization
  include ExceptionsHandlers
  protect_from_forgery prepend: true
  before_action :authenticate_facebook_user
end
