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
end
