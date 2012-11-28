class Node < ActiveRecord::Base
  attr_accessible :name, :short_name, :classify, :parent_id
  attr_accessor :node_name
  validates_presence_of :name, :short_name, :classify
  validates_inclusion_of :classify, :in => ['city', 'school', 'area']

  has_many :events
  has_many :children, :class_name => 'Node', :foreign_key => 'parent_id', :order => 'name DESC'
  belongs_to :parent, :class_name => 'Node'
  delegate :name, :to => :parent, :prefix => true, :allow_nil => true
end
