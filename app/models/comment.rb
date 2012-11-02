class Comment < ActiveRecord::Base
  attr_accessible :content
  
  belongs_to :event, foreign_key: 'event_id'
  belongs_to :user, foreign_key: 'user_id'
  has_many :messages, :dependent => :destroy

  validates_presence_of :content, :event_id, :user_id
  
  scope :recent, order: 'created_at DESC'

  after_create do
    Comment.send_event_comment_message(self.id)
  end
  def self.send_event_comment_message(comment_id)
    comment = Comment.find(comment_id)
    return if comment.blank?
    event = comment.event
    return if event.blank?
    if comment.user_id != event.user_id
      Message.create :user_id => event.user_id, :comment_id => comment_id
    end
  end

end
