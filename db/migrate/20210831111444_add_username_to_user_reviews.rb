class AddUsernameToUserReviews < ActiveRecord::Migration[6.0]
  def change
    add_column :user_reviews, :username, :string
  end
end
