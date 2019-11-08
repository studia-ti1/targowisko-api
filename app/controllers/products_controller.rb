# frozen_string_literal: true

class ProductsController < ApplicationController
  include Pagy::Backend

  def index
    user_products = @user.products
    @products = if user_products.size != 0
                 _, paginated_collection = pagy(user_products, items: params[:items] || user_products.size, page: params[:page] || 1)
                 paginated_collection
               else
                 []
               end

    render json: @products
  end

  def show
    render json: @user.products.find(params[:id])
  end

  def create
    render json: @user.products.create(product_params)
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

  private

  def product_params
    params.permit(:name, :price, :picture, :category)
  end
end
