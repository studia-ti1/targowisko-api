# frozen_string_literal: true

class AddLocationToMarkets < ActiveRecord::Migration[5.2]
  def change
    add_column :markets, :location, :jsonb
    remove_column :markets, :address, :string
  end
end
