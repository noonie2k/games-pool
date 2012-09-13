class Game < ActiveRecord::Base
  belongs_to :platform
  belongs_to :owner, class_name: 'User'
  has_many :loans

  attr_accessible :img_thumb_url, :img_tiny_url, :platform_id, :title

  validates :owner, :platform, :title, presence: true

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
end
