# -*- coding: utf-8 -*-
require 'file_size_validator'
class Event < ActiveRecord::Base
  attr_accessible :title, :start_date, :end_date, :location, :content, :category, :fee, :image
  mount_uploader :image, ImageUploader
  
  has_many :comments
  belongs_to :user, foreign_key: 'user_id'

  validates :title, presence: {message: "标题不能为空"}
  validates :location, presence: {message: "地点不能为空"}
  validates :content, presence: {message: "活动详情不能为空"}
  validates :fee, presence: {message: "费用不能为空"}
  validates :category, presence: {message: "分类不能为空"}
  validates :user_id, presence: true
  validates :image, :presence => {message: "需要上传海报"}, :file_size => { :maximum => 1.megabytes.to_i, message: "文件大小必须在1M以内"}
  scope :recent, :order => 'start_date DESC'
end
