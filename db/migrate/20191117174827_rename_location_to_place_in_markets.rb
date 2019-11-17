# frozen_string_literal: true

class RenameLocationToPlaceInMarkets < ActiveRecord::Migration[5.2]
  def change
    rename_column :markets, :location, :place
  end
end
