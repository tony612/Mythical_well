# -*- coding: utf-8 -*-
require 'file_size_validator'
class Event < ActiveRecord::Base
  attr_accessible :title, :start_date, :end_date, :date_desc, :location, :content, :category_id, :theme, :fee, :image, :tag_tokens, :node_id, :capacity
  mount_uploader :image, ImageUploader

  has_many :comments, :dependent => :destroy
  belongs_to :user, foreign_key: 'user_id'
  delegate :username, :name, :to => :user, :prefix => true, :allow_nil => true

  has_many :event_tags, :dependent => :destroy
  has_many :tags, :through => :event_tags

  has_many :event_followers
  has_many :followers, :class_name => 'User', :through => :event_followers, :order => 'event_followers.created_at DESC'

  belongs_to :node, foreign_key: 'node_id'
  delegate :name, :to => :node, :prefix => true, :allow_nil => true

  belongs_to :category, foreign_key: 'category_id'
  delegate :name, :to => :category, :prefix => true, :allow_nil => true

  validates :title, presence: {message: "标题不能为空"}
  validates :location, presence: {message: "地点不能为空"}
  validates :content, presence: {message: "活动详情不能为空"}
  validates :fee, presence: {message: "费用不能为空"}
  validates :category_id, presence: {message: "分类不能为空"}
  #validates :theme, presence: { message: "主题不能为空" }
  validates :user_id, presence: true
  validates :image, :presence => {message: "需要上传海报"}, :file_size => { :maximum => 1.megabytes.to_i, message: "文件大小必须在1M以内"}
  validates :node_id, presence: {message: '需要选择学校'}
  scope :recent, :order => 'start_date DESC'

  attr_reader :tag_tokens
  def tag_tokens=(tokens)
    self.tag_ids = Tag.ids_from_tokens(tokens)
  end

  def self.complex_find(params = {})
    nodes_arr = []
    if params[:short_name]
      node = Node.find_by_short_name(params[:short_name])
      if node.classify == 'school'
        nodes_arr = [node.id]
      elsif node.classify == 'city'
        nodes_arr = node.children.map do |ch|
          ch.classify == 'area' ? ch.children.map(&:id) : ch.id
        end.flatten
      elsif node.classify == 'area'
        nodes_arr = node.children.map(&:id)
      end
    end
    with_node = nodes_arr.empty? ? Event : Event.where(:node_id => nodes_arr)
    if params[:category]
      category = Category.find_by_name(params[:category])
      unless category.blank?
        events = with_node.where(:category_id => category.id).recent.page(params[:page])
      end
    elsif params[:tag]
      events = find_with_tag(params[:tag]).where(:node_id => nodes_arr).recent.page(params[:page]) unless nodes_arr.empty?
      events = find_with_tag(params[:tag]).recent.page(params[:page]) if nodes_arr.empty?
    else
      events = with_node.includes(:user).recent.page(params[:page])
    end
    events
  end

  def self.find_with_tag(tag)
    Tag.find_by_name(tag).events
  end

  after_destroy :delete_img
  def delete_img
    remove_image
  end

  def user_follow_type(user)
    event_followers.where(:user_id => user.id)[0].classify
  end

  def attendees
    attendship = event_followers.where(:classify => 'attend')
    followers.where(:id => attendship.map(&:user_id))
  end

  def watchers
    attendship = event_followers.where(:classify => 'watch')
    followers.where(:id => attendship.map(&:user_id))
  end

end
