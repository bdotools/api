class AddTargetToResults < ActiveRecord::Migration[5.0]
  def change
    add_reference :results, :target, foreign_key: true
  end
end
