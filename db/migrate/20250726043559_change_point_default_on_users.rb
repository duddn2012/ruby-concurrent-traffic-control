class ChangePointDefaultOnUsers < ActiveRecord::Migration[8.0]
  def change
    change_column_default :users, :point, 0
  end
end
