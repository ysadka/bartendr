class IngredientSerializer < ActiveModel::Serializer
  attributes :name, :hex_color, :purchase_url
end
