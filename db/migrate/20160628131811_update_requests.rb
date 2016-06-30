class UpdateRequests < ActiveRecord::Migration
  def change
    add_column :requests, :collectible_id, :integer
  end
end
