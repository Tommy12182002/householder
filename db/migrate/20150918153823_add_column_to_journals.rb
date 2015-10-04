class AddColumnToJournals < ActiveRecord::Migration
  def change
    add_column :journals, :year, :integer
    rename_column :journals, :title, :remarks
    add_index :journals, [:user_id, :year, :month], :name => "index_journal_on_year"
  end
end
