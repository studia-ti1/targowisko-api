# frozen_string_literal: true

class UsersController < ApplicationController
  include Pagy::Backend

  def index
    @users = []
    User.all.by_first_name(params[:user_first_name]).by_last_name(params[:user_last_name]).each do |user|
      @users << user unless user.products.empty?
    end

    render json: @users
  end

  def show
    render json: User.find(params[:id])
  end
end
