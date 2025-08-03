class CreateEvents < ActiveRecord::Migration[8.0]
  def change
    create_table :events do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :visit_count
      t.boolean :win_status

      t.timestamps
    end
  end
end
