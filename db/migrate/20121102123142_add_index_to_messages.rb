class AddIndexToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :comment_id, :integer
    add_index :messages, :comment_id
  end
end
