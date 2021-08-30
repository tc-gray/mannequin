class CreateUserReviews < ActiveRecord::Migration[6.0]
  def change
    create_table :user_reviews do |t|
      t.integer :rating
      t.text :content
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
