class CreateSolveInProgress < ActiveRecord::Migration[5.0]
  def change
    create_table :solve_in_progress do |t|
      t.references :target, foreign_key: true
      t.integer :target_interest
      t.integer :target_favor
    end
  end
end
