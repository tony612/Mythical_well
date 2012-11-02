class RemoveEventIdFromMessages < ActiveRecord::Migration
  def up
    remove_column :messages, :event_id
    add_column :messages, :comment_id, :integer
  end

  def down
    add_column :messages, :event_id, :integer
    remove_column :messages, :comment_id
  end
end
