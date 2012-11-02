class Message < ActiveRecord::Base
  attr_accessible :is_read, :user_id, :comment_id

  belongs_to :user, :foreign_key => 'user_id'
  belongs_to :comment, :foreign_key => 'comment_id'
end
