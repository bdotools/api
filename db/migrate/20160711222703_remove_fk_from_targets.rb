class RemoveFkFromTargets < ActiveRecord::Migration[5.0]
  def change
    remove_foreign_key :targets, :categories
    remove_foreign_key :targets, :constellations
  end
end
