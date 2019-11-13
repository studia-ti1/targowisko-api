# frozen_string_literal: true

class RemoveNullFalseFromProductAndMarket < ActiveRecord::Migration[5.2]
  def change
    change_column_null :products, :category, true
    change_column_null :markets, :category, true
  end
end
