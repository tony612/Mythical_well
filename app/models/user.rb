class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :authentication_keys => [:login]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :city, :email, :name, :school, :username
  
  #Use email or username to login
  attr_accessor :login
  attr_accessible :login

  validates :username, presence: true, length: {within: 4..50}, uniqueness: {:case_sensitive => true}, format: {:with => /^[A-Za-z]\w+$/}

  has_many :events

  before_save :email_normalisation

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end

  private

  def email_normalisation
    self.email = email.strip.downcase
  end
end
