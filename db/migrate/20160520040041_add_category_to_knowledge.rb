class AddCategoryToKnowledge < ActiveRecord::Migration[5.0]
  def change
    add_reference :knowledges, :category, foreign_key: true
  end
end
