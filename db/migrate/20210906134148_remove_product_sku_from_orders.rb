class RemoveProductSkuFromOrders < ActiveRecord::Migration[6.0]
  def change
    remove_column :orders, :product_sku
  end
end
