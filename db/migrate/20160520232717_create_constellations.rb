class CreateConstellations < ActiveRecord::Migration[5.0]
  def change
    create_table :constellations do |t|
      t.string :name
      t.integer :slots
      t.integer :slot_order, array: true, default: []

      t.timestamps
    end
  end
end
