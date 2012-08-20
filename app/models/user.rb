class User < ActiveRecord::Base
  has_secure_password
  
  attr_accessible :email, :name, :username

  validates :email, :name, :username, presence: true
  validates :email, :username, uniqueness: true
end
