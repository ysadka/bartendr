class AddIndexToComponents < ActiveRecord::Migration
  def change
    add_index(:components, [:drink_id, :ingredient_id], unique: true)
  end
end
