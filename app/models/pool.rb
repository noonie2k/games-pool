class Pool < ActiveRecord::Base
  has_many :memberships
  has_many :members, through: :memberships, source: :user

  attr_accessible :name, :invite_code

  validates :name, :invite_code, presence: true
  validates :name, uniqueness: true

  def authenticate(entered_code)
    invite_code === entered_code
  end
end
