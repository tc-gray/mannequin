class BookingsController < ApplicationController
  def new
    @booking = Booking.new
    @product = Product.find(params[:product_id])
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.user = current_user
    # sets status as pending
    @booking.status = "Pending"
    @product = Product.find(params[:product_id])
    @booking.product = @product
    if @booking.save
      redirect_to confirmation_product_bookings_path(@product)
    else
      render "bookings/new"
    end
  end

  def update
    @booking = Booking.find(params[:id])
    @booking.update(booking_params)
    redirect_to user_path
  end

  def confirmation
    @product = Product.find(params[:product_id])
    @booking = @product.bookings.last
  end

  def accept_booking
    @booking = Booking.find(params[:id])
    # need to access the product_id of item to be booked
    # also the user whose product is booked needs to be notified
    # and cosmetic changes need to happen for the index page/show page to show item is booked
    # need to show option for user to accept/decline booking
    @user = @booking.user
    if @booking.status == "Pending"
      # then update the status to "Accepted"
      @booking.status = "Accepted"
    end
  end

  def decline_booking
    @booking = Booking.find(params[:id])
    @user = @booking.user
    if @booking.status == "Pending"
      # then update the status to "Declined"
      @booking.status = "Declined"
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :status)
  end
end
