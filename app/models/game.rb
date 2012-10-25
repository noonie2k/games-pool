require 'digest/md5'

class Game < ActiveRecord::Base
  belongs_to :platform
  belongs_to :owner, class_name: 'User'
  has_many :loans

  attr_accessible :img_thumb_url, :img_tiny_url, :md5, :platform_id, :title

  validates :owner, :platform, :title, presence: true
  validates :md5, uniqueness: { message: 'A game with this title and platform already exists in your collection' }

  before_validation :build_md5
  after_validation :attach_md5_message_to_title

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
    return AVAILABILITY_ONHOLD if loans.where(status: Loan::STATUS_ONHOLD).any?
    return AVAILABILITY_ONLOAN if loans.where(status: Loan::STATUS_ONLOAN).any?

    AVAILABILITY_AVAILABLE
  end

  protected

  def build_md5
    self.md5 = Digest::MD5.hexdigest("#{title}-#{platform.id}-#{owner.id}")
  end

  def attach_md5_message_to_title
    if errors[:md5].present?
      errors[:title] << errors[:md5][0]
    end
  end
end
