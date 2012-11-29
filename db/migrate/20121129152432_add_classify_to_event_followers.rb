class AddClassifyToEventFollowers < ActiveRecord::Migration
  def change
    add_column :event_followers, :classify, :string
  end
end
