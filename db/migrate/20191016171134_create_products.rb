class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.references :user, foreign_key: true
      t.string :name, null: false
      t.integer :price, null: false
      t.string :picture
      t.integer :category, null: false

      t.timestamps
    end
  end
end
