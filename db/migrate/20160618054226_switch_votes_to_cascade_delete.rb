class SwitchVotesToCascadeDelete < ActiveRecord::Migration[5.0]
  def change
    remove_foreign_key :votes, :results
    add_foreign_key :votes, :results, on_delete: :cascade
  end
end
