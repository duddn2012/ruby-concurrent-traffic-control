class CreateUserPointHistories < ActiveRecord::Migration[8.0]
  def change
    create_table :user_point_histories do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :earn_point
      t.references :event, null: false, foreign_key: true

      t.timestamps
    end
  end
end
