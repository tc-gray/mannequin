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
    @deliveries = Delivery.new
    @product = Product.find(params[:product_id])
    @booking = Booking.find(params[:booking_id])
  end

  def create

  end

  private

  def delivery_params
    params.require(:delivery).permit(:address, :latitude, :longitude)
  end
end
