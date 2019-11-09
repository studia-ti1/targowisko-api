# frozen_string_literal: true

class AddLocationToMarkets < ActiveRecord::Migration[5.2]
  def change
    change_table :markets, bulk: true do |t|
      t.jsonb :location
      t.string :address
    end
  end
end
