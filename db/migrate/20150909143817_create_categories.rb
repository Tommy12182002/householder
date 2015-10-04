class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :category
      t.string :user_id
      t.timestamps null: false
    end

    add_index :categories, [:user_id], name: "index_category_on_user_id"
    add_index :categories, [:user_id, :category], name: "index_category", :unique => true
  end
end
