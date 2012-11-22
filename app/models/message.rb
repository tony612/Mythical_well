class Message < ActiveRecord::Base
  attr_accessible :is_read, :user_id, :comment_id, :msg_type
  
  def self.EVENT_TYPE; 1; end
  def self.MENTION_TYPE; 2; end
  #def self.FOLLOW_EVENT_TYPE; 3; end

  belongs_to :user, :foreign_key => 'user_id'
  belongs_to :comment, :foreign_key => 'comment_id'

  scope :unread, where(:is_read => false)
  scope :recent, order("created_at DESC")
end
