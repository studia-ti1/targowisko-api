# frozen_string_literal: true

class CreateUserEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :user_events do |t|
      t.references :user, foreign_key: true
      t.references :market, foreign_key: true
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
