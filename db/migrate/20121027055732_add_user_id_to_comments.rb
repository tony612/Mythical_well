class AddUserIdToComments < ActiveRecord::Migration
  def change
    add_column :comments, :user_id, :integer
    #remove_column :comments, :time, :datetime
    add_index :comments, :user_id
  end
end
