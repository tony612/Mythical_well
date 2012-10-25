class User < ActiveRecord::Base
  attr_accessible :city, :email, :name, :password_digest, :school, :username

  has_many :events
end
