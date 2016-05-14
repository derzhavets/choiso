class CreateAlternatives < ActiveRecord::Migration
  def change
    create_table :alternatives do |t|
      t.string :name
      t.integer :proposed_by
      t.belongs_to :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
