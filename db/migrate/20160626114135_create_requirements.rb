class CreateRequirements < ActiveRecord::Migration
  def change
    create_table :requirements do |t|
      t.integer :alternative_id
      t.string :name
      t.integer :user_id
      t.integer :proposer_id

      t.timestamps null: false
    end
  end
end
