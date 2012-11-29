class EventFollower < ActiveRecord::Base
  attr_accessible :event_id, :user_id, :classify

  belongs_to :follow_event, :class_name => "Event", :foreign_key => 'event_id'
  belongs_to :follower, :class_name => "User", :foreign_key => 'user_id'
end
