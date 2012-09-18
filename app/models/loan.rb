class Loan < ActiveRecord::Base
  belongs_to :user
  belongs_to :game
  attr_accessible :game, :status, :user

  STATUS_ONHOLD   = 1
  STATUS_ONLOAN   = 2
  STATUS_RETURNED = 3

  scope :active, where(status: [Loan::STATUS_ONHOLD, Loan::STATUS_ONLOAN])
  scope :held, where(status: Loan::STATUS_ONHOLD)
  scope :out, where(status: Loan::STATUS_ONLOAN)

  # Find loans for games with the specified md5 hash
  scope :md5, lambda { |md5| joins(:game).where('games.md5 = ?', md5) }

  before_save :default_status

  def default_status 
    self.status ||= Loan::STATUS_ONHOLD
  end
end
