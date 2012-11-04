class Message < ActiveRecord::Base
  attr_accessible :is_read, :user_id, :comment_id

  belongs_to :user, :foreign_key => 'user_id'
  belongs_to :comment, :foreign_key => 'comment_id'

  scope :unread, where(:is_read => false)
  scope :recent, order("created_at DESC")
  #after_create :realtime_push_message
  #def realtime_push_message
  #  if self.user
  #    hash = {count: self.user.messages.unread.count}
  #  end
  #end

end
