class ProductReviewsController < ApplicationController
  before_action :find_product, except: :destroy

  # def new
  #   @product_review = ProductReview.new
  # end

  def create
    @product_review = ProductReview.new(product_review_params)
    @product_review.product = @product
    @product_review.user = current_user
    if @product_review.save
      redirect_to product_path(@product)
    else
      render 'products/show'
    end
  end

  private

  def find_product
    # need to find which product the review belongs to
    @product = Product.find(params[:product_id])
  end

  def product_review_params
    params.require(:product_review).permit(:content, :rating)
  end
end
