class CreatePrepTypes < ActiveRecord::Migration
  def change
    create_table :prep_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
