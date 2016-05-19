class AddIndexToAlternatives < ActiveRecord::Migration
  def change
      add_index :alternatives, :proposer_id
  end
end
