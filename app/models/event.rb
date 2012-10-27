class Event < ActiveRecord::Base
  attr_accessible :title, :start_date, :end_date, :location, :content, :category, :fee
  
  has_many :comments
  belongs_to :user, foreign_key: 'user_id'

  validates_presence_of :title, :location, :content, :category, :fee, :user_id
end
