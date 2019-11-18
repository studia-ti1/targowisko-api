# frozen_string_literal: true

class AddAverageRatingToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :average_rating, :float
  end
end
