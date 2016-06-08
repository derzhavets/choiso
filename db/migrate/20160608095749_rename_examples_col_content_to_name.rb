class RenameExamplesColContentToName < ActiveRecord::Migration
  def change
    rename_column :examples, :content, :name
  end
end
