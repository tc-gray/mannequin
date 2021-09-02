class BookingsController < ApplicationController
  def new
    @booking = Booking.new
    @product = Product.find(params[:product_id])
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.user = current_user
    @product = Product.find(params[:product_id])
    @booking.product = @product
    if @booking.save
      redirect_to confirmation_product_bookings_path(@product)
    else
      render "bookings/new"
    end
  end

  def confirmation
    @product = Product.find(params[:product_id])
    @booking = @product.bookings.last
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date)
  end
end
