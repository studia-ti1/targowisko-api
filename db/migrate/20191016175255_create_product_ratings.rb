# frozen_string_literal: true

class CreateProductRatings < ActiveRecord::Migration[5.2]
  def change
    create_table :product_ratings do |t|
      t.references :product, foreign_key: true
      t.references :user, foreign_key: true
      t.integer :rating
      t.text :comment

      t.timestamps
    end
  end
end
