class CreateExamples < ActiveRecord::Migration
  def change
    create_table :examples do |t|
      t.string :exampleable_type
      t.string :exampleable
      t.string :content
      t.timestamps null: false
    end
  end
end
