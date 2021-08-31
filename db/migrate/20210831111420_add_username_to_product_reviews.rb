class AddUsernameToProductReviews < ActiveRecord::Migration[6.0]
  def change
    add_column :product_reviews, :username, :string
  end
end
