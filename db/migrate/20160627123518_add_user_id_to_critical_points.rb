class AddUserIdToCriticalPoints < ActiveRecord::Migration
  def change
    add_column :critical_points, :user_id, :integer
  end
end
