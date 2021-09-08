class BookingsController < ApplicationController
  def new
    @booking = Booking.new
    @product = Product.find(params[:product_id])
    # the `geocoded` scope filters only flats with coordinates (latitude & longitude)
    @deliveries = Delivery.all
  end

  def create
    @booking = Booking.new(booking_params)
    @product = Product.find(params[:product_id])
    @booking.user = current_user
    @booking.owner = @product.user
    # sets status as pending
    @booking.status = "Pending"
    @booking.product = @product
    if @booking.save
      create_order
      redirect_to new_product_booking_delivery_path(@product, @booking)
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

  def destroy
    @booking = Booking.find(params[:id])
    @booking.destroy
    redirect_to user_path(current_user)
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :status)
  end

  def create_order
    order = Order.create!(booking: @booking, amount: @booking.product.price, state: 'pending', user: current_user)

    session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [{ name: @booking.product.name.parameterize,
        images: [Cloudinary::Utils.cloudinary_url(@booking.product.photos.first.key)],
        amount: @booking.product.price_cents,
        currency: 'gbp',
        quantity: 1
      }],
      success_url: order_url(order),
      cancel_url: order_url(order)
    )

    order.update(checkout_session_id: session.id)
    # redirect_to new_order_payment_path(order)
  end

end
