# -*- coding: utf-8 -*-
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :authentication_keys => [:login]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :password, :password_confirmation, :remember_me
  attr_accessible :city, :name, :school, :gender, :website, :tagline
  attr_accessible :username, :email, :events_count, :comments_count, :followed_users_count, :followers_count
  #validates :login, presence: {message: "用户名或密码不能为空"}
  #validates :password, presence: true

  before_update :revert_login_if_changed, :if => Proc.new { |u| u.username_changed? || u.email_changed? }
  
  #Use email or username to login
  attr_accessor :login
  attr_accessible :login

  validates :username, presence: {message: "用户名不能为空"}, length: {within: 4..50, message: "长度为4~50个字符"}, uniqueness: {:case_sensitive => true, message: "用户名已经存在"}, format: {:with => /^[A-Za-z]\w+$/, message: "必须由字母或下划线组成"}
  #### Follow relationship
  has_many :events, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  # As follwoer
  has_many :followships, foreign_key: 'follower_id', dependent: :destroy
  has_many :followed_users, through: :followships, source: :followed
  has_many :reverse_followships, foreign_key: 'followed_id', class_name: 'Followship', dependent: :destroy
  has_many :followers, through: :reverse_followships, source: :follower

  # Message
  has_many :messages, :dependent => :destroy

  ###Event follow
  has_many :event_followers
  has_many :follow_events, :class_name => 'Event', :through => :event_followers

  before_save :email_normalisation
  def to_param
    username
  end

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end

  def following?(other_user)
    followships.find_by_followed_id(other_user.id)
  end

  def follow!(other_user)
    followships.create!(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    followships.find_by_followed_id(other_user.id).destroy
  end

  def followed_by?(other_user)
    reverse_followships.find_by_follower_id(other_user.id)
  end

  def unfollowed!(other_user)
    reverse_followships.find_by_follower_id(other_user.id).destroy
  end

  def read_messages(messages)
  end

  def has_role?(role)
    case role
      when :admin then admin?
      when :member then true
      else false
    end
  end

  private
  
  def revert_login_if_changed
    self.username = self.username_was
    self.email = self.email_was
  end

  def email_normalisation
    self.email = email.strip.downcase
  end

  def admin?
    Setting.admin_emails.include?(self.email)
  end
end
