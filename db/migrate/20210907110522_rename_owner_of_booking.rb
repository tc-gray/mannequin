class RenameOwnerOfBooking < ActiveRecord::Migration[6.0]
  def change
    add_column :bookings, :owner_id, :integer
    remove_column :bookings, :user
  end
end
