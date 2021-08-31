class AddUsernameToProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :username, :string
  end
end
