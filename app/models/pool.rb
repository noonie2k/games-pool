class Pool < ActiveRecord::Base
  has_secure_password

  attr_accessible :name

  validates :name, presence: true
  validates :name, uniqueness: true
end
