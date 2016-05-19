class FixAlternativesColumnProposer < ActiveRecord::Migration
  def change
    rename_column :alternatives, :proposed_by, :proposer_id
  end
end
