class Pool < ActiveRecord::Base
  has_many :memberships
  has_many :members, through: :memberships, source: :user

  attr_accessible :name, :invite_code

  validates :name, presence: true
  validates :name, uniqueness: true

  def authenticate(entered_code)
    invite_code === entered_code
  end

  def games(exclude_user = nil)
    # get games belonging to other members of this pool
    pool_games = members.collect { |member| member.games unless exclude_user && member == exclude_user }.flatten.compact

    # group the games by md5 hash
    # keep the game with the fewest active loans
    pool_games.group_by(&:md5).each_with_object([]) do |md5, unique|
      unique << md5[1].sort { |x, y| x.loans.active.count <=> y.loans.active.count }.first
    end
  end
end
