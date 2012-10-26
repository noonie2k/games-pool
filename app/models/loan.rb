class Loan < ActiveRecord::Base
  belongs_to :user
  belongs_to :game
  attr_accessible :game, :status, :user

  STATUS_ONHOLD    = 1
  STATUS_ONLOAN    = 2
  STATUS_COMPLETED = 3

  scope :active, where(status: [Loan::STATUS_ONHOLD, Loan::STATUS_ONLOAN])
  scope :held, where(status: Loan::STATUS_ONHOLD)
  scope :out, where(status: Loan::STATUS_ONLOAN)

  # Find loans for games with the specified md5 hash
  scope :md5, lambda { |md5| joins(:game).where('games.md5 = ?', md5) }

  validates :game, :user, presence: true
  validate :user_does_not_own_the_same_game_on_the_same_platform,
           :user_does_not_have_active_loans_on_the_same_game_on_the_same_platform

  before_save :default_status

  protected

  def default_status
    self.status ||= Loan::STATUS_ONHOLD
  end

  def user_does_not_own_the_same_game_on_the_same_platform
    if user && user.games.where(md5: game.md5).any?
      errors.add(:game, "You can't loan games that you own")
    end
  end

  def user_does_not_have_active_loans_on_the_same_game_on_the_same_platform
    if user && user.loans.md5(game.md5).any?
      errors.add(:game, "You already have an active hold/loan on #{game.title}")
    end
  end
end
