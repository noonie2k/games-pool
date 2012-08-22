class Membership < ActiveRecord::Base
  belongs_to :pool
  belongs_to :user

  attr_accessible :pool, :user

  validates :pool, :user, presence: true
end
