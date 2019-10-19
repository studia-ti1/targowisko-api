# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include CustomExceptions
  include ExceptionsHandlers
  include Authorization
  before_action :authenticate_facebook_user
end
