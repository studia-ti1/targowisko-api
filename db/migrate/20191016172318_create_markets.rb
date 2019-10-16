class CreateMarkets < ActiveRecord::Migration[5.2]
  def change
    create_table :markets do |t|
      t.string :name, null: false
      t.json :address, null: false
      t.text :description
      t.string :facebook_event_id
      t.integer :category, null: false
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
