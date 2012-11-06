class Comment < ActiveRecord::Base
  attr_accessible :content, :mention_users
  
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
      Message.create :user_id => event.user_id, :comment_id => comment_id, :msg_type => Message.EVENT_TYPE
    end
  end

  before_save :extract_mentioned_users
  after_create :send_mention_messages
  after_destroy :delete_mention_messages
  
  def extract_mentioned_users
    usernames = content.scan(/@(\S*)\s/).flatten
    if usernames.any?
      self.mention_users = User.where(:username => usernames).where('username != ?', user.username).limit(5).map(&:id) * '|'
    else
      self.mention_users = ""
    end
  end
  
  def mentioning_users
    User.find(mention_users.split('|'))
  end

  def no_mention_users
    [user]
  end

  def send_mention_messages
    return true if mention_users == ""
    (mentioning_users - no_mention_users).each do |u|
      Message.create :user_id => u.id, :comment_id => id, :msg_type => Message.MENTION_TYPE
    end
  end

end
