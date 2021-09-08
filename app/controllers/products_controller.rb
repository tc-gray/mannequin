class ProductsController < ApplicationController
  before_action :find_product, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: :toggle_favorite

  def index
    if params[:query].present?
      @products = Product.search_by_name_and_description_and_size_and_category(params[:query])
      session[:search_query] = params[:query]
    elsif params[:category].present?
      if session[:search_query]
        @search = Product.search_by_name_and_description_and_size_and_category(session[:search_query])
        @products = @search.where("category ILIKE ?", "%#{params[:category]}%")
      else
        # @products = Product.search_by_name_and_description_and_size_and_category(params[:category])
        @products = Product.where("category ILIKE ?", "%#{params[:category]}%")
        session.delete("search_query")
      end
    else
      @products = Product.all
    end
  end

  def show
    @products = Product.all
    @product_review = ProductReview.new(product: @product)
    @user_products = @product.user.products.where.not(id: @product.id)
  end

  def new
    @product = Product.new
    # we need to authorize anyone to make a product (when they have an account)
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
    if @product.update(product_params)
      redirect_to @product, notice: 'Product was successfully updated'
    end
  end

  def destroy
    @product.destroy
    redirect_to products_path
  end

   def toggle_favorite
    @product = Product.find_by(id: params[:id])
    current_user.favorited?(@product)  ?current_user.unfavorite(@product) : current_user.favorite(@product)
    redirect_to product_path(@product)
  end

  private

  def find_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :description, :category, :size, :price, photos:[])
  end
end
