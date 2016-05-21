class CreateTargets < ActiveRecord::Migration[5.0]
  def change
    create_table :targets do |t|
      t.string :name
      t.integer :favor_min
      t.integer :favor_max
      t.integer :interest_min
      t.integer :interest_max

      t.timestamps
    end
  end
end
