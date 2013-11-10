class DrinkSerializer < ActiveModel::Serializer
  attributes :name, :preparation
  has_many :components
  has_one :glass

  def name
    object.name.split(' ').map(&:capitalize).join(' ')
  end
end
