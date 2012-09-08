class Game < ActiveRecord::Base
  belongs_to :platform
  belongs_to :owner, class_name: 'User'

  attr_accessible :img_thumb_url, :img_tiny_url, :platform_id, :title

  validates :owner, :platform, :title, presence: true

  SIZE_TINY  = 'tiny'
  SIZE_THUMB = 'thumb'

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
end
