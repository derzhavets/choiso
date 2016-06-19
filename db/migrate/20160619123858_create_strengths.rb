class CreateStrengths < ActiveRecord::Migration
  def change
    create_table :strengths do |t|
      t.string :name
      t.integer :user_id
      t.integer :proposer_id

      t.timestamps null: false
    end
  add_index :strengths, :proposer_id
  end
end
