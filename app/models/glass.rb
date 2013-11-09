class Glass < ActiveRecord::Base
  validates :name, presence: true
  validates :img_url, presence: true

  has_many :drinks

  def purchase_url
    "https://www.google.com/#q=#{CGI.escape(name).downcase}+glass&tbm=shop"
  end
end
