class AddEventsCountToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :events_count, :integer, default: 0
    add_column :users, :comments_count, :integer, default: 0
    add_column :users, :followships_count, :integer, default: 0
    add_column :users, :reverse_followships_count, :integer, default: 0

    User.all.each do |user|
      user.update_attribute :events_count, user.events.count
      user.update_attribute :comments_count, user.comments.count
      user.update_attribute :followships_count, user.followed_users.count
      user.update_attribute :reverse_followships_count, user.reverse_followships.count
    end
  end

  def self.down
    remove_column :users, :events_count
    remove_column :users, :comments_count
    remove_column :users, :followers_count
    remove_column :users, :followed_users_count
  end
end
