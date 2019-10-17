class CreateMarkets < ActiveRecord::Migration[5.2]
  def change
    create_table :markets do |t|
      t.string :name
      t.string :add
      t.text :description
      t.jsonb :location
      t.string :facebook_event_id
      t.string :name
    end
  end
end
