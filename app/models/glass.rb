class Glass < ActiveRecord::Base
  validates :name, presence: true
  validates :img_url, presence: true

  has_many :drinks

  def purchase_url
    "http://www.amazon.com/gp/search?ie=UTF8&camp=1789&creative=9325&index=aps&keywords=#{CGI.escape(name).downcase}%20glasses&linkCode=ur2&tag=bartendrme-20"
  end
end
