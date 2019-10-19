# frozen_string_literal: true

class CreateProductsMarkets < ActiveRecord::Migration[5.2]
  def change
    create_table :products_markets do |t|
      t.references :product, foreign_key: true
      t.references :market, foreign_key: true

      t.timestamps
    end
  end
end
