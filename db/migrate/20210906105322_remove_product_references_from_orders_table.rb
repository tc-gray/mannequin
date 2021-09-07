class RemoveProductReferencesFromOrdersTable < ActiveRecord::Migration[6.0]
  def change
    remove_reference :orders, :product
  end
end
