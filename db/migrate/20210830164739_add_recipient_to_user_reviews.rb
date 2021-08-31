class AddRecipientToUserReviews < ActiveRecord::Migration[6.0]
  def change
    add_reference :user_reviews, :recipient
  end
end
