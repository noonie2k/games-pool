class Platform < ActiveRecord::Base
  attr_accessible :color_code, :name

  validates :color_code, :name, presence: true
  validates :color_code, :name, uniqueness: true
  validates :color_code, format: { with: /^#([0-9a-fA-F]{3}){1,2}$/, message: 'Not a valid color code' }
end
