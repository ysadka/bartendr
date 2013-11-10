class CreateDrinks < ActiveRecord::Migration
  def change
    create_table :drinks do |t|
      t.string :name
      t.text :preparation
      t.integer :glass_id

      t.timestamps
    end
  end
end
