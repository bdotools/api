class CreateKnowledges < ActiveRecord::Migration[5.0]
  def change
    create_table :knowledges do |t|
      t.integer :combo_delay
      t.integer :combo_favor
      t.integer :combo_interest
      t.integer :combo_length
      t.integer :favor_max
      t.integer :favor_min
      t.integer :interest
      t.string :name

      t.timestamps
    end
  end
end
