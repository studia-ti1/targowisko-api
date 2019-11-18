# frozen_string_literal: true

class ProductsController < ApplicationController
  include Pagy::Backend
  DEFAULT_NUMBER_OF_TOP_PRODUCTS = 5

  def index
    products = Product.all.by_user(params[:user_id]).by_name(params[:search_value]).by_market(params[:market_id])
    products = if !products.empty?
                  _, paginated_collection = pagy(products, items: params[:items] || products.size, page: params[:page] || 1)
                  paginated_collection
                else
                  []
                end

    render json: products
  end

  def show
    render json: @user.products.find(params[:id])
  end

  def create
    render json: @user.products.create!(product_params)
  end

  def destroy
    @user.products.destroy(params[:id])

    render json: { status: 'deleted' }
  end

  def update
    product = @user.products.find(params[:id])
    product.update(product_params)

    render json: product
  end

  def top_products
    top_products_avg_ids = ProductRating.group(:product_id).average(:rating).sort { |a, b| b[1] <=> a[1] }.first(params[:count].to_i || DEFAULT_NUMBER_OF_TOP_PRODUCTS)
    top_products_ids = top_products_avg_ids.map(&:first)
    products = Product.where(id: top_products_ids)

    render json: products
  end

  private

  def product_params
    params.permit(:name, :price, :category, :picture)
  end
end
