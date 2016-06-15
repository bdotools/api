class AddDaumId < ActiveRecord::Migration[5.0]
  def change
    add_column :categories, :daum_id, :integer
    add_index :categories, :daum_id, unique: true

    add_column :knowledges, :daum_id, :integer
    add_index :knowledges, :daum_id, unique: true

    add_column :targets, :daum_id, :integer
    add_index :targets, :daum_id, unique: true
  end
end
