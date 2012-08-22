class Pool < ActiveRecord::Base
  has_secure_password

  has_many :memberships
  has_many :members, through: :memberships, source: :user

  attr_accessible :name

  validates :name, presence: true
  validates :name, uniqueness: true
end
