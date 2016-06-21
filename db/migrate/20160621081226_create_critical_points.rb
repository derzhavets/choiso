class CreateCriticalPoints < ActiveRecord::Migration
  def change
    create_table :critical_points do |t|
      t.integer :alternative_id
      t.references :point, polymorphic: true, index: true

      t.timestamps null: false
    end
  end
end
