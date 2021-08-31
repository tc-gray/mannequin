class AddUsernameToBookings < ActiveRecord::Migration[6.0]
  def change
    add_column :bookings, :username, :string
  end
end
