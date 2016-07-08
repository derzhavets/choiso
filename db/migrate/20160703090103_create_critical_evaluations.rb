class CreateCriticalEvaluations < ActiveRecord::Migration
  def change
    create_table :critical_evaluations do |t|
      t.integer :alternative_id
      t.integer :rater_id
      t.integer :score
      t.text :critical_points

      t.timestamps null: false
    end
  end
end
