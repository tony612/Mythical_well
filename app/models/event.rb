# -*- coding: utf-8 -*-
require 'file_size_validator'
class Event < ActiveRecord::Base
  attr_accessible :title, :start_date, :end_date, :date_desc, :location, :content, :category, :fee, :image, :tag_tokens, :node_id
  mount_uploader :image, ImageUploader

  has_many :comments, :dependent => :destroy
  belongs_to :user, foreign_key: 'user_id'

  has_many :event_tags, :dependent => :destroy
  has_many :tags, :through => :event_tags

  has_many :event_followers
  has_many :followers, :class_name => 'User', :through => :event_followers

  belongs_to :node, foreign_key: 'node_id'


  validates :title, presence: {message: "标题不能为空"}
  validates :location, presence: {message: "地点不能为空"}
  validates :content, presence: {message: "活动详情不能为空"}
  validates :fee, presence: {message: "费用不能为空"}
  validates :category, presence: {message: "分类不能为空"}
  validates :user_id, presence: true
  validates :image, :presence => {message: "需要上传海报"}, :file_size => { :maximum => 1.megabytes.to_i, message: "文件大小必须在1M以内"}
  validates :node_id, presence: {message: '需要选择学校'}
  scope :recent, :order => 'start_date DESC'

  attr_reader :tag_tokens
  def tag_tokens=(tokens)
    self.tag_ids = Tag.ids_from_tokens(tokens)
  end

  after_destroy :delete_img
  def delete_img
    remove_image
  end
end
