class AddNameToDeliveries < ActiveRecord::Migration[6.0]
  def change
    add_column :deliveries, :name, :string
  end
end
