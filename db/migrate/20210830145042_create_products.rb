class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.string :category
      t.string :size
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
