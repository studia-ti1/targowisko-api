# frozen_string_literal: true

class AddImageToMarkets < ActiveRecord::Migration[5.2]
  def change
    add_column :markets, :image, :string
  end
end
