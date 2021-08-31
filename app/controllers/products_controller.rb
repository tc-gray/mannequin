class ProductsController < ApplicationController
  def index
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
    # we need to authorize anyone to make a product (if they have an account)
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
