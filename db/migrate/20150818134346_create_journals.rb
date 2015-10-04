class CreateJournals < ActiveRecord::Migration
  def change
    create_table :journals do |t|
			t.date :document_date, null: false
			t.integer :month, null: false
      t.string   :title, null: false
      t.string   :category, null: false
      t.integer :amount, null: false
      t.boolean :summary, default: true
			t.string :user_id, null: false
      t.timestamps null: false
    end
		
		add_index :journals, [:user_id], name: "index_journal_on_user_id"
		add_index :journals, [:user_id, :document_date], name: "index_journal_on_document_date"
		add_index :journals, [:user_id, :month], name: "index_journal_on_month"
		add_index :journals, [:user_id, :category], name: "index_journal_on_category"

  end
end
