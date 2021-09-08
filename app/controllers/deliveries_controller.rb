class DeliveriesController < ApplicationController
  def index
    @deliveries = Delivery.all

    # the `geocoded` scope filters only delivery with coordinates (latitude & longitude)
    # @markers = @deliveries.geocoded.map do |delivery|
    #   {
    #     lat: delivery.latitude,
    #     lng: delivery.longitude
    #   }
    # end
  end

  def new
    @deliveries = Delivery.all
    @product = Product.find(params[:product_id])
    @booking = Booking.find(params[:booking_id])
    @delivery = Delivery.new
    @markers = @deliveries.geocoded.map do |delivery|
      {
        lat: delivery.latitude,
        lng: delivery.longitude,
        info_window: render_to_string(partial: "deliveries/info_window", locals: { delivery: delivery, product: @product, booking: @booking })
      }
    end
  end

  def create
    @deliveries = Delivery.all
    @product = Product.find(params[:product_id])
    @booking = Booking.find(params[:booking_id])
    @delivery = Delivery.new
    @delivery.booking = @booking
    @booking.user = current_user
    @booking.owner = @product.user
    if @delivery.save
      redirect_to user_path(current_user)
    else
      @markers = @deliveries.geocoded.map do |delivery|
        {
          lat: delivery.latitude,
          lng: delivery.longitude,
          info_window: render_to_string(partial: "deliveries/info_window", locals: { delivery: delivery, product: @product, booking: @booking })
        }
      end
      render 'deliveries/new'
    end
  end

  private

  def delivery_params
    params.require(:delivery).permit(:address, :latitude, :longitude, :booking_id)
  end
end
