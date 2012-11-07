class Tag < ActiveRecord::Base
  attr_accessible :name

  has_many :event_tags, :dependent => :destroy
  has_many :events, :through => :event_tags
end
