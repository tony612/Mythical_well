class AddIndexToEventFollowers < ActiveRecord::Migration
  def change
    add_index :event_followers, :event_id
    add_index :event_followers, :user_id
    add_index :event_tags, :event_id
    add_index :event_tags, :tag_id
    add_index :nodes, :parent_id

  end
end
