# frozen_string_literal: true

class AddDatesToMarkets < ActiveRecord::Migration[5.2]
  def change
    change_table :markets, bulk: true do |t|
      t.datetime :starts_at
      t.datetime :ends_at
    end
  end
end
