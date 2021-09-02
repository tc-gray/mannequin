class ProductsController < ApplicationController
  before_action :find_product, only: [:show, :update, :destroy]

  def index
    if params[:query].present?
      sql_query = " \
        products.name ILIKE :query \
        OR products.description ILIKE :query \
        OR users.username ILIKE :query \
      "
      @products = Product.joins(:user).where(sql_query, query: "%#{params[:query]}%")
    else
      @products = Product.all
    end
  end

  def show
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
