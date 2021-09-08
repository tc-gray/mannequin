class AddBookingToDeliveries < ActiveRecord::Migration[6.0]
  def change
    add_reference :deliveries, :booking, foreign_key: true
  end
end
