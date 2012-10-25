class Event < ActiveRecord::Base
  attr_accessible :title, :start_date, :location, :content

  has_many :comments
end
