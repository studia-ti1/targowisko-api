# frozen_string_literal: true

class AdjustMarketsToFacebookApi < ActiveRecord::Migration[5.2]
  def change
    change_column :markets, :category, :integer, null: true
  end
end
