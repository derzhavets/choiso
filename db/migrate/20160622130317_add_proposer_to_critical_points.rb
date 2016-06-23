class AddProposerToCriticalPoints < ActiveRecord::Migration
  def change
    add_column :critical_points, :proposer_id, :integer
  end
end
