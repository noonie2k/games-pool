require 'digest/md5'

class Game < ActiveRecord::Base
  belongs_to :platform
  belongs_to :owner, class_name: 'User'
  has_many :loans

  attr_accessible :img_thumb_url, :img_tiny_url, :md5, :owner_id, :platform_id, :title

  validates :owner, :platform, :title, :md5, presence: true
  validate :unique_in_collection

  before_validation :build_md5

  SIZE_TINY  = 'tiny'
  SIZE_THUMB = 'thumb'

  AVAILABILITY_AVAILABLE = 'available'
  AVAILABILITY_ONHOLD    = 'on_hold'
  AVAILABILITY_ONLOAN    = 'on_loan'

  def image(size)
    begin
      url = send("img_#{size}_url")
      if url.empty?
        placeholder
      else
        url
      end
    rescue
      return placeholder
    end
  end

  def placeholder
    ActionController::Base::helpers.asset_path('placeholder.png')
  end

  def availability
    game_availability = AVAILABILITY_AVAILABLE
    game_availability = AVAILABILITY_ONHOLD if loans.where(status: Loan::STATUS_ONHOLD).any?
    game_availability = AVAILABILITY_ONLOAN if loans.where(status: Loan::STATUS_ONLOAN).any?

    game_availability
  end

  protected

  def build_md5
    self.md5 = Digest::MD5.hexdigest("#{title}-#{platform.id}") if platform.present?
  end

  def unique_in_collection
    if owner && owner.games.where(md5: md5).any?
      errors.add(:title, 'A game with this title and platform already exists in your collection')
    end
  end
end
