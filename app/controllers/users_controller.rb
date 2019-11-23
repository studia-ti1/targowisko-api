# frozen_string_literal: true

class UsersController < ApplicationController
  include Pagy::Backend

  def index
    @users = []
    User.all.each do |user|
      @users << user unless user.products.empty?
    end

    render json: @users
  end

  def show
    render json: User.find(params[:id])
  end
end
