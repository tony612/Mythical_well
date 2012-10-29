require 'file_size_validator'
class Event < ActiveRecord::Base
  attr_accessible :title, :start_date, :end_date, :location, :content, :category, :fee, :image
  mount_uploader :image, ImageUploader
  
  has_many :comments
  belongs_to :user, foreign_key: 'user_id'

  validates_presence_of :title, :location, :content, :category, :fee, :user_id
  validates :image, :presence => true, :file_size => { :maximum => 1.megabytes.to_i }
  scope :recent, :order => 'start_date DESC'
end
