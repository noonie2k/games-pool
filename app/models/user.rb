class User < ActiveRecord::Base
  has_secure_password

  has_many :games, foreign_key: :owner_id
  has_many :memberships
  has_many :pools, through: :memberships
  
  attr_accessible :email, :name, :username

  validates :email, :name, :username, presence: true
  validates :email, :username, uniqueness: true
end
