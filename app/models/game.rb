class Game < ActiveRecord::Base
  belongs_to :platform
  belongs_to :owner, class_name: 'User'

  attr_accessible :img_thumb_url, :img_tiny_url, :platform_id, :title

  validates :owner, :platform, :title, presence: true
end
