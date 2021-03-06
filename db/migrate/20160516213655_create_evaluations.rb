class CreateEvaluations < ActiveRecord::Migration
  def change
    create_table :evaluations do |t|
      t.integer :score
      t.references :rater, polymorphic: true, index: true
      t.references :rateable, polymorphic: true, index: true
      t.timestamps null: false
    end
  end
end
