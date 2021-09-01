class ProductsController < ApplicationController
  before_action :find_product, only: [:show, :update, :destroy]

  def index
    @products = Product.all
  end

  def show
    @product_review = ProductReview.new(product: @product)
  end

  def new
    @product = Product.new
    # we need to authorize anyone to make a product (if they have an account)
  end

  def create
    @product = Product.new(product_params)
    @product.user = current_user
    if @product.save
      redirect_to product_path(@product)
    else
      render :new
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def find_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :description, :category, :size, photos: [])
  end
end
