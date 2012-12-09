class AddCategoryIdToEvents < ActiveRecord::Migration
  def change
    add_column :events, :category_id, :integer
    remove_column :events, :category
  end
end
