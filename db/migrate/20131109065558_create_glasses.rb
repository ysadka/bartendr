class CreateGlasses < ActiveRecord::Migration
  def change
    create_table :glasses do |t|
      t.string :name
      t.string :img_url
      t.string :purchase_url

      t.timestamps
    end
  end
end
