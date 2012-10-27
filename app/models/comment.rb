class Comment < ActiveRecord::Base
  attr_accessible :content
  
  belongs_to :event, foreign_key: 'event_id'
  belongs_to :user, foreign_key: 'user_id'

  validates_presence_of :content, :event_id, :user_id
  
end
