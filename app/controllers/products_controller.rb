class ProductsController < ApplicationController
  before_action :find_product, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: :toggle_favorite

  def index
    if params[:query].present?
      filter_query_results(params[:query])
    elsif params[:category].present? || params[:size].present?
      filter_category_results(params)
    elsif params["sort-by"].present?
      filter_sort_results(params["sort-by"])
    else
      @products = Product.all
      delete_sessions
    end
  end


  def show
    @products = Product.all
    @product_review = ProductReview.new(product: @product)
    @user_products = @product.user.products.where.not(id: @product.id)
    # @chatroom = Chatroom.find_by(user: current_user, product: @product)
    @chatroom = Chatroom.new
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

  def filter_query_results(params)
    session[:search_query] = params
    if session[:search_category] && session[:search_sort]
      search = Product.where("category ILIKE ?", "%#{session[:search_category]}%")
      array = search.search_by_name_and_description_and_size_and_category(params)
      @products = sort(array, session[:search_sort])
    elsif session[:search_category]
      search = Product.where("category ILIKE ?", "%#{session[:search_category]}%")
      @products = search.search_by_name_and_description_and_size_and_category(params)
    elsif session[:search_sort]
      array = Product.search_by_name_and_description_and_size_and_category(params)
      @products = sort(array, session[:search_sort])
    else
      @products = Product.search_by_name_and_description_and_size_and_category(params)
    end
  end

  def filter_category_results(params)
    session[:search_category] = params
    if session[:search_query] && session[:search_sort]
      search = Product.search_by_name_and_description_and_size_and_category(session[:search_query])
      size_array = search.where("size ILIKE ?", "%#{params[:size]}%")
      array = size_array.where("category ILIKE ?", "%#{params[:category]}%")
      @products = sort(array, session[:search_sort])
    elsif session[:search_query]
      search = Product.search_by_name_and_description_and_size_and_category(session[:search_query])
      size_array = search.where("size ILIKE ?", "%#{params[:size]}%")
      @products = size_array.where("category ILIKE ?", "%#{params[:category]}%")
    elsif session[:search_sort]
      size_array = Product.where("size ILIKE ?", "%#{params[:size]}%")
      array = size_array.where("category ILIKE ?", "%#{params[:category]}%")
      @products = sort(array, session[:search_sort])
    else
      size_array = Product.where("size ILIKE ?", "%#{params[:size]}%")
      @products = size_array.where("category ILIKE ?", "%#{params[:category]}%")
    end
  end

  def filter_sort_results(params)
    session[:search_sort] = params
    if session[:search_query] && session[:search_category]
      search = Product.search_by_name_and_description_and_size_and_category(session[:search_query])
      array = search.where("category ILIKE ?", "%#{session[:search_category]}%")
      @products = sort(array, params)
    elsif session[:search_query]
      array = Product.search_by_name_and_description_and_size_and_category(session[:search_query])
      @products = sort(array, params)
    elsif session[:search_category]
      array = search.where("category ILIKE ?", "%#{session[:search_category]}%")
      @products = sort(array, params)
    else
      @products = sort(Product.all, params)
    end
  end

  def sort(array, sort_by)
    if sort_by == "accending"
      array.sort_by(&:price_cents)
    else
      array.sort_by(&:price_cents).reverse
    end
  end

  def delete_sessions
    session.delete("search_query")
    session.delete("search_sort")
    session.delete("search_category")
  end
end
