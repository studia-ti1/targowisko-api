# frozen_string_literal: true

class AddAverageRatingToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :average_rating, :float
  end
end
