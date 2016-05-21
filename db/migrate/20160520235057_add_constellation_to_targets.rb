class AddConstellationToTargets < ActiveRecord::Migration[5.0]
  def change
    add_reference :targets, :constellation, foreign_key: true
  end
end
