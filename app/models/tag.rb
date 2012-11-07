# encoding: utf-8
class Tag < ActiveRecord::Base
  attr_accessible :name

  has_many :event_tags, :dependent => :destroy
  has_many :events, :through => :event_tags

  def self.tokens(query)
    tags = where("name like ?", "%#{query}%")
    if tags.empty?
      [{id: "<<<#{query}>>>", name: "新标签: \"#{query}\""}]
    else
      tags
    end
  end

  def self.ids_from_tokens(tokens)
    tokens.gsub!(/<<<(.+?)>>>/) { create!(name: $1).id }
    tokens.split(',')
  end
end
