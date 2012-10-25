class AddIndexToEvents < ActiveRecord::Migration
  def change
    add_index :events, :user_id
    add_index :comments, :event_id
  end
end
