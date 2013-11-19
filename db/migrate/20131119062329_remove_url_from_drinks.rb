class RemoveUrlFromDrinks < ActiveRecord::Migration
  def change
    remove_column :drinks, :url
  end
end
