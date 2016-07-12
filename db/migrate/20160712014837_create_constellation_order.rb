class CreateConstellationOrder < ActiveRecord::Migration[5.0]
  def change
    create_table :constellation_orders do |t|
      t.integer :constellation_id
      t.integer :daum_id
      t.integer :slot_order, array: true, default: []
    end
    add_index :constellation_orders, :constellation_id
    add_index :constellation_orders, :daum_id, unique: true
  end
end
