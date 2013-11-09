class Glass < ActiveRecord::Base
  validates :name, presence: true
  validates :img_url, presence: true

  has_many :drinks
end
