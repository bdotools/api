class AddCategoryToTarget < ActiveRecord::Migration[5.0]
  def change
    add_reference :targets, :category, foreign_key: true
  end
end
