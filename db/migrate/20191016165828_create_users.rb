class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :last_name, null: false
      t.string :first_name, null: false
      t.string :email, null: false
      t.string :password, null: false
      t.string :phone_number
      t.integer :role, null: false, default: 0

      t.timestamps
    end
  end
end
