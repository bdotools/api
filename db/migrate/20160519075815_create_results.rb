class CreateResults < ActiveRecord::Migration[5.0]
  def change
    create_table :results do |t|
      t.integer :goal
      t.integer :goal_param
      t.float :strict_afl_ev
      t.float :success_percentage
      t.integer :target_interest
      t.integer :target_favor

      t.timestamps
    end
  end
end
