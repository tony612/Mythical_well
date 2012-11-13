# -*- coding: utf-8 -*-
require 'file_size_validator'
class Event < ActiveRecord::Base
  attr_accessible :title, :start_date, :end_date, :date_desc, :location, :content, :category, :fee, :image, :tag_tokens
  mount_uploader :image, ImageUploader
  
  has_many :comments, :dependent => :destroy
  belongs_to :user, foreign_key: 'user_id'

  has_many :event_tags, :dependent => :destroy
  has_many :tags, :through => :event_tags

  has_many :event_followers
  has_many :followers, :class_name => 'User', :through => :event_followers

  validates :title, presence: {message: "标题不能为空"}
  validates :location, presence: {message: "地点不能为空"}
  validates :content, presence: {message: "活动详情不能为空"}
  validates :fee, presence: {message: "费用不能为空"}
  validates :category, presence: {message: "分类不能为空"}
  validates :user_id, presence: true
  validates :image, :presence => {message: "需要上传海报"}, :file_size => { :maximum => 1.megabytes.to_i, message: "文件大小必须在1M以内"}
  scope :recent, :order => 'start_date DESC'
  
  attr_reader :tag_tokens
  def tag_tokens=(tokens)
    self.tag_ids = Tag.ids_from_tokens(tokens)
  end

#  def tagging(tag_names)
#    event_tags.where('tag_id NOT IN (?)', Tag.find_all_by_name(tag_names).map(&:id)).each {|t| t.destroy}
#    tag_names.each do |tag|
#      unless tags.where(name: tag).exists?
#        if Tag.where(name: tag).exists?
#          EventTag.create(event_id: id, tag_id: Tag.find_by_name(tag).id)
#        else
#          t = Tag.create(name: tag)
#          EventTag.create(event_id: id, tag_id: t.id)
#        end
#      end
#    end
#  end
end
