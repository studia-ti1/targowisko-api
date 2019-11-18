# frozen_string_literal: true

class AddAverageRatingToMarkets < ActiveRecord::Migration[5.2]
  def change
    add_column :markets, :average_rating, :float
  end
end
