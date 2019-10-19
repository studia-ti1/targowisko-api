# frozen_string_literal: true

class CreateMarketRatings < ActiveRecord::Migration[5.2]
  def change
    create_table :market_ratings do |t|
      t.references :market, foreign_key: true
      t.references :user, foreign_key: true
      t.integer :rating
      t.text :comment

      t.timestamps
    end
  end
end
