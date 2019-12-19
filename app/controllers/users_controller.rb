# frozen_string_literal: true

class UsersController < ApplicationController
  include Pagy::Backend
  DEFAULT_NUMBER_OF_TOP_USERS = 5

  def index
    @users = []
    User.all.by_first_name(params[:user_first_name]).by_last_name(params[:user_last_name]).each do |user|
      @users << user unless user.products.empty?
    end

    paginated_users = if !@users.empty?
                        _, paginated_collection = pagy(@users, items: params[:items] || @users.size, page: params[:page] || 1)
                        paginated_collection
                      else
                        []
                      end

    render json: paginated_users
  end

  def update_avatar
    @user.update!(avatar: user_params[:avatar])
    render json: @user
  end

  def api_update_avatar
    @user.remote_avatar_url = @profile.dig('picture', 'data', 'url')
    @user.save!

    render json: @user
  end

  def destroy
    @user.destroy!
    render json: { deleted: true }
  end

  def show
    render json: User.find(params[:id])
  end

  def about_me
    render json: @user
  end

  def top_users
    top_users_avg_ids = UserRating.group(:user_id).average(:rating).sort { |a, b| b[1] <=> a[1] }.first(params[:count].to_i || DEFAULT_NUMBER_OF_TOP_USERS)
    top_users_ids = top_users_avg_ids.map(&:first)
    users = User.where(id: top_users_ids)

    paginated_users = if !users.empty?
                        _, paginated_collection = pagy(users, items: params[:items] || users.size, page: params[:page] || 1)
                        paginated_collection
                      else
                        []
                      end

    render json: paginated_users
  end

  private

  def user_params
    params.permit(:avatar)
  end
end
