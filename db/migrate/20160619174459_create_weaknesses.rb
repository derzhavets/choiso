class CreateWeaknesses < ActiveRecord::Migration
  def change
    create_table :weaknesses do |t|
      t.string :name
      t.integer :user_id
      t.integer :proposer_id

      t.timestamps null: false
    end
  add_index :weaknesses, :proposer_id  
  end

end
