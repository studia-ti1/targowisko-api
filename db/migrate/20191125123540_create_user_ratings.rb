class CreateUserRatings < ActiveRecord::Migration[5.2]
  def change
    create_table :user_ratings do |t|
      t.integer :rating
      t.text :comment
      t.references :rater, foreign_key: { to_table: 'users' }
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
