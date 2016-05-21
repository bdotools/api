class AddIndexesToNameFields < ActiveRecord::Migration[5.0]
  def change
    add_index :categories, :name
    add_index :knowledges, :name
    add_index :targets, :name
  end
end
