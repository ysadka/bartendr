class Ingredient < ActiveRecord::Base
  validates :name, presence: true

  has_many :components
  has_many :drinks, through: :components

  belongs_to :color

  def purchase_url
    "https://www.google.com/#q=#{CGI.escape(name).downcase}&tbm=shop"
  end
end
