# frozen_string_literal: true

class UsersController < ApplicationController
  include Pagy::Backend
  DEFAULT_NUMBER_OF_TOP_USERS = 5

  def index
    @users = []
    User.all.by_first_name(params[:user_first_name]).by_last_name(params[:user_last_name]).each do |user|
      @users << user unless user.products.empty?
    end

    render json: @users
  end

  def update_avatar
    @user.update!(avatar: user_params[:avatar])
    render json: @user
  end

  def destroy
    @user.destroy!
    render json: { deleted: true }
  end

  def show
    render json: User.find(params[:id])
  end

  def top_users
    top_users_avg_ids = UserRating.group(:user_id).average(:rating).sort { |a, b| b[1] <=> a[1] }.first(params[:count].to_i || DEFAULT_NUMBER_OF_TOP_USERS)
    top_users_ids = top_users_avg_ids.map(&:first)
    users = User.where(id: top_users_ids)

    render json: users
  end

  private

  def user_params
    params.permit(:avatar)
  end
end
