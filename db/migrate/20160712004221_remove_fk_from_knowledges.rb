class RemoveFkFromKnowledges < ActiveRecord::Migration[5.0]
  def change
    remove_foreign_key :knowledges, :categories
  end
end
