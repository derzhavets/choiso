class AddRankToAlternatives < ActiveRecord::Migration
  def change
    add_column :alternatives, :rank, :integer
  end
end
