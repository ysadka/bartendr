class CreateDrinks < ActiveRecord::Migration
  def change
    create_table :drinks do |t|
      t.string :name
      t.integer :glass_id
      t.integer :prep_type_id

      t.timestamps
    end
  end
end
