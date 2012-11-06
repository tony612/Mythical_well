class AddMentionUsersToComments < ActiveRecord::Migration
  def change
    add_column :comments, :mention_users, :string
  end
end
