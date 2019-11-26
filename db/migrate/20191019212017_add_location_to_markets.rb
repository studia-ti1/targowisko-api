# frozen_string_literal: true

class AddLocationToMarkets < ActiveRecord::Migration[5.2]
  def change
    remove_column :markets, :address, :string
    change_table :markets, bulk: true do |t|
      t.jsonb :location
    end
  end
end
