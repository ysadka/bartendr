class DrinkSerializer < ActiveModel::Serializer
  attributes :name, :preparation
  has_many :components
  has_one :glass

  def name
    object.name.titleize
  end
end
