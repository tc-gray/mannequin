class AddbookingRefToOrders < ActiveRecord::Migration[6.0]
  def change
    add_reference :orders, :booking, foreign_key: true
  end
end
