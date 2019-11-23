# frozen_string_literal: true

class UsersController < ApplicationController
  include Pagy::Backend

  def index
    @users = []
    User.all.each do |user|
      @users << user unless user.products.nil?
    end

    render json: @users
  end
end
