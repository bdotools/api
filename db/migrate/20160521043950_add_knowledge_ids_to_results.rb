class AddKnowledgeIdsToResults < ActiveRecord::Migration[5.0]
  def change
    add_column :results, :knowledge_ids, :integer, array: true, default: []
  end
end
