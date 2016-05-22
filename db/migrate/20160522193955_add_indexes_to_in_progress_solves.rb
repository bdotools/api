class AddIndexesToInProgressSolves < ActiveRecord::Migration[5.0]
  def change
    add_index :solve_in_progress, [:target_id, :target_interest, :target_favor], unique: true, name: "index_solve_in_progress_unique"
  end
end
